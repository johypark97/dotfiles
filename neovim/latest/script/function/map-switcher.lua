-- =============================
-- -------- MapSwitcher --------
-- =============================

local MapSwitcher = {}

-- -------- private --------

function MapSwitcher:_error(format, ...)
    local args = { ... }
    error(string.format('MapSwitcher: ' .. format, unpack(args)))
end

function MapSwitcher:_isReady()
    if self.executor == '' then
        self:_error('executor is not defined')
    end

    if #self.mapTable == 0 then
        self:_error('map table is not defined')
    end
end

function MapSwitcher:_isVaildMapTable(value)
    -- check presets
    for presetKey, presetValue in pairs(value) do
        -- check the key is integer
        if type(presetKey) ~= 'number' then
            self:_error('the map table must consist only of integer indexes')
        end

        -- check name and mapping is defined in preset
        for _, testKey in pairs({ 'name', 'mapping' }) do
            if not presetValue[testKey] then
                self:_error("'%s' is not defined in the map table", testKey)
            end
        end

        -- check mapping of preset
        for mappingKey, mappingValue in pairs(presetValue.mapping) do
            -- check isNore, isSilent, and rhs is defined in each key
            for _, testKey in pairs({ 'isNore', 'isSilent', 'rhs' }) do
                if not mappingValue[testKey] then
                    self:_error("'%s' is not defined in key '%s' of '%s'", testKey, mappingKey, presetValue.name)
                end
            end
        end
    end
end

function MapSwitcher:map()
    local keys = {}
    for _, i in pairs(self.mapTable) do
        for j, _ in pairs(i.mapping) do
            if not keys[j] then
                keys[j] = true
            end
        end
    end

    for i, _ in pairs(keys) do
        local newRhs = string.format(":lua %s:key('%s')<CR>", self.globalInstanceName, i:gsub('<', '<lt>'))

        -- maparg(i, 'n') converts the <Leader> and cause map fail
        local mappedRhs = vim.fn.get(vim.fn.maparg(i, 'n', 0, 1), 'rhs', '')
        if mappedRhs == '' then
            vim.cmd(string.format('nnoremap <unique> <silent> %s %s', i, newRhs))
        elseif mappedRhs ~= newRhs then
            self:_error("mapping failed: '%s' is already mapped to '%s'", i, mappedRhs)
        end
    end
end

-- -------- public --------

function MapSwitcher:new(globalInstanceName)
    local instance = {}

    instance.executor = ''
    instance.globalInstanceName = globalInstanceName
    instance.index = 1
    instance.mapTable = {}

    return setmetatable(instance, { __index = self })
end

function MapSwitcher:newKey(key, isNore, isSilent, rhs)
    return { [key] = { isNore = isNore, isSilent = isSilent, rhs = rhs } }
end

function MapSwitcher:newPreset(name, ...)
    local args = { ... }

    local preset = { name = name, mapping = {} }
    for _, i in pairs(args) do
        for key, value in pairs(i) do
            preset.mapping[key] = value
        end
    end

    return preset
end

function MapSwitcher:newMapTable(...)
    local args = { ... }
    return args
end

function MapSwitcher:init(executor, mapTable)
    self.executor = executor
    self.mapTable = mapTable

    -- valid map table
    local status, err = pcall(self._isVaildMapTable, self, mapTable)
    if not status then
        print(err)
        return
    end
    self.mapTable = mapTable

    -- mapping
    local status, err = pcall(self.map, self)
    if not status then
        print(err)
        return
    end
end

function MapSwitcher:help()
    local status, err = pcall(self._isReady, self)
    if not status then
        print(err)
        return
    end

    local preset = self.mapTable[self.index]

    local length = 0
    for i, _ in pairs(preset.mapping) do
        local temp = #i
        if temp > length then
            length = temp
        end
    end

    vim.cmd(string.format("echo '<%s>'", preset.name))
    local format = string.gsub("echo '%*s: %s'", '*', length)
    for key, value in pairs(preset.mapping) do
        vim.cmd(string.format(format, key, value.rhs))
    end
end

function MapSwitcher:switch()
    local status, err = pcall(self._isReady, self)
    if not status then
        print(err)
        return
    end

    local length = #self.mapTable

    self.index = self.index + 1
    if self.index > length then
        self.index = 1
    end

    local name = self.mapTable[self.index].name
    vim.cmd(string.format("echo 'MapSwitcher(%d/%d): %s'", self.index, length, name))
end

function MapSwitcher:key(value)
    local status, err = pcall(self._isReady, self)
    if not status then
        print(err)
        return
    end

    local key = self.mapTable[self.index].mapping[value]
    if key then
        local command = {}
        table.insert(command, key.isNore and 'nnoremap' or 'nmap')
        table.insert(command, '<buffer>')
        table.insert(command, key.isSilent and '<silent>' or '')
        table.insert(command, self.executor)
        table.insert(command, key.rhs)
        vim.cmd(table.concat(command, ' '))

        local executor = vim.api.nvim_replace_termcodes(self.executor, true, true, true)
        vim.api.nvim_feedkeys(executor, '', true)
    end
end

-- -------- return --------

return MapSwitcher
