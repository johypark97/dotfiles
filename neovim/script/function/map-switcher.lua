-- =============================
-- -------- MapSwitcher --------
-- =============================

local MapSwitcher = {}

-- -------- public --------

function MapSwitcher:new(globalInstanceName)
    local instance = {}

    instance._GLOBAL_INSTANCE_NAME = globalInstanceName
    instance._KEY_METHOD_NAME = "pressKey"

    instance._executor = nil
    instance._presetIndex = 1
    instance._presetList = {}

    return setmetatable(instance, { __index = self })
end

function MapSwitcher:setExecutor(value)
    if value == nil then error("value is nil") end

    self._executor = value
end

function MapSwitcher:addKey(preset, key, rhs, option)
    if preset == nil then error("preset is nil") end
    if key == nil then error("key is nil") end
    if rhs == nil then error("rhs is nil") end
    option = option or {}

    local x

    for _, value in ipairs(self._presetList) do
        if value.name == preset then
            x = value
            break
        end
    end

    if not x then
        x = { name = preset, map = {} }
        table.insert(self._presetList, x)
    end

    x.map[key] = {
        option = option,
        rhs = rhs,
    }
end

function MapSwitcher:apply()
    local status, e = pcall(self._isReady, self)
    if not status then
        print(e)
        return
    end

    local keySet = {}
    for _, preset in ipairs(self._presetList) do
        for key, _ in pairs(preset.map) do
            if not keySet[key] then
                keySet[key] = true
            end
        end
    end

    for key, _ in pairs(keySet) do
        local rhs = string.format("<Cmd>lua %s:%s('%s')<CR>",
                self._GLOBAL_INSTANCE_NAME, self._KEY_METHOD_NAME,
                key:gsub("<", "<lt>"))

        local mapped = vim.fn.maparg(key, "n", false, true)
        if not next(mapped) then
            vim.keymap.set("n", key, rhs, { unique = true })
        elseif mapped.rhs ~= rhs then
            self:_error("cannot map to %s (%s)", key, mapped.rhs)
        end
    end
end

function MapSwitcher:help()
    local status, e = pcall(self._isReady, self)
    if not status then
        print(e)
        return
    end

    local preset = self._presetList[self._presetIndex]

    local length = 0
    for key, _ in pairs(preset.map) do
        local x = #key
        if x > length then
            length = x
        end
    end

    print(string.format("<< %s >>", preset.name))
    local format = string.format("%%%ds: %%s", length)
    for key, value in pairs(preset.map) do
        print(string.format(format, key, value.rhs))
    end
end

function MapSwitcher:switchPreset()
    local status, e = pcall(self._isReady, self)
    if not status then
        print(e)
        return
    end

    local length = #self._presetList

    self._presetIndex = self._presetIndex + 1
    if self._presetIndex > length then
        self._presetIndex = 1
    end

    print(string.format("MapSwitcher(%d/%d): %s", self._presetIndex, length,
            self._presetList[self._presetIndex].name))
end

function MapSwitcher:pressKey(key)
    if key == nil then error("key is nil") end

    local status, e = pcall(self._isReady, self)
    if not status then
        print(e)
        return
    end

    local map = self._presetList[self._presetIndex].map[key]
    if map then
        local option = {}
        for k, v in pairs(map.option) do option[k] = v end
        option.buffer = true

        vim.keymap.set("n", self._executor, map.rhs, option)

        local executor = vim.api.nvim_replace_termcodes(self._executor, true, true, true)
        vim.api.nvim_feedkeys(executor, "", true)
    end
end

-- -------- private --------

function MapSwitcher:_error(format, ...)
    local args = { ... }

    error(string.format("MapSwitcher: " .. format, unpack(args)), 0)
end

function MapSwitcher:_isReady()
    if not self._executor then
        self:_error("executor is not set")
    end

    if #self._presetList == 0 then
        self:_error("no keys were added")
    end
end

-- -------- return --------

return MapSwitcher
