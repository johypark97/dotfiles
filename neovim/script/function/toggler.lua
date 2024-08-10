-- =========================
-- -------- Toggler --------
-- =========================

local Toggler = {}

-- -------- public --------

function Toggler:new()
    local instance = {}

    instance._INITIAL_VALUE = setmetatable({}, {
        __index = {
            list = vim.o.list,
            number = vim.o.number,
            signcolumn = vim.o.signcolumn,
        },
        __newindex = function() error("_INITIAL_VALUE is read-only") end,
    })

    instance._callbackList = {}

    return setmetatable(instance, { __index = self })
end

function Toggler:toggleGuide()
    local x = vim.wo.list == self._INITIAL_VALUE.list
            and vim.wo.number == self._INITIAL_VALUE.number
            and vim.wo.signcolumn == self._INITIAL_VALUE.signcolumn

    if x then
        vim.wo.list = false
        vim.wo.number = false
        vim.wo.signcolumn = "no"
    else
        vim.wo.list = self._INITIAL_VALUE.list
        vim.wo.number = self._INITIAL_VALUE.number
        vim.wo.signcolumn = self._INITIAL_VALUE.signcolumn
    end

    for _, callback in pairs(self._callbackList) do
        callback(not x)
    end
end

function Toggler:addCallback(value)
    if type(value) ~= "function" then
        error("value is not a function")
    end

    table.insert(self._callbackList, value)
end

-- -------- return --------

return Toggler
