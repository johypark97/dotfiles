-- =====================
-- -------- Set --------
-- =====================

local Set = {}

-- -------- static --------

function Set.fromList(value)
    local set = Set:new()

    set:addAll(value)

    return set
end

-- -------- public --------

function Set:new()
    local instance = {}

    instance._table = {}

    return setmetatable(instance, { __index = self })
end

function Set:isEmpty()
    return next(self._table) == nil
end

function Set:count()
    local x = 0

    for _ in pairs(self._table) do
        x = x + 1
    end

    return x
end

function Set:clear()
    self._table = {}
end

function Set:contains(value)
    if value == nil then
        error("value is nil")
    end

    return self._table[value] == true
end

function Set:add(value)
    if value == nil then
        error("value is nil")
    end

    self._table[value] = true
end

function Set:addAll(value)
    if value == nil then
        error("value is nil")
    elseif type(value) ~= "table" then
        error("value is not a list")
    end

    for _, x in pairs(value) do
        self:add(x)
    end
end

function Set:remove(value)
    if value == nil then
        error("value is nil")
    end

    self._table[value] = nil
end

function Set:toList()
    local list = {}

    for x in pairs(self._table) do
        table.insert(list, x)
    end

    return list
end

-- -------- return --------

return Set
