-- =================================
-- -------- PostInitializer --------
-- =================================

local PostInitializer = {}

-- -------- public --------

function PostInitializer:new()
    local instance = {}

    instance._callbackList = {}

    return setmetatable(instance, { __index = self })
end

function PostInitializer:addCallback(value)
    if type(value) ~= "function" then
        error("value is not a function")
    end

    table.insert(self._callbackList, value)
end

function PostInitializer:initialize()
    for _, value in pairs(self._callbackList) do
        value()
    end
end

-- -------- return --------

return PostInitializer
