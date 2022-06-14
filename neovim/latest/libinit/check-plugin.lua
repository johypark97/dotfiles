-- ==============================
-- -------- check plugin --------
-- ==============================

return function(...)
    if packer_plugins == nil then
        return false
    end

    local args = { ... }
    for _, value in pairs(args) do
        if packer_plugins[value] == nil then
            return false
        end
    end

    return true
end
