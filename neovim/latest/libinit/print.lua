-- =======================
-- -------- print --------
-- =======================

local function p(value, indentLevel)
    indentLevel = indentLevel or 1

    local indentChar = '  '
    local indent = string.rep(indentChar, indentLevel)

    for key, value in pairs(value) do
        if type(value) == 'table' then
            print(indent .. key .. ' = {')
            p(value, indentLevel + 1)
            print(indent .. '}')
        elseif type(value) == 'string' then
            print(string.format("%s%s = '%s'", indent, key, tostring(value)))
        else
            print(string.format('%s%s = %s', indent, key, tostring(value)))
        end
    end
end

return function(value)
    if type(value) == 'table' then
        print('{')
        p(value)
        print('}')
    else
        print(value)
    end
end
