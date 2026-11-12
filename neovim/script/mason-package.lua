-- =========================
-- -------- package --------
-- =========================

local mason_registry = require("mason-registry")

local list = {
    "black",
    "prettier",
    "shellcheck",
}

local set = Init.Set:new()
for _, x in pairs(list) do
    if not mason_registry.is_installed(x) then
        set:add(x)
    end
end

if not set:isEmpty() then
    vim.notify(
        "The following packages require manual installation. Please install using Mason.",
        vim.log.levels.WARN)

    for _, x in pairs(set:toList()) do
        vim.notify("- " .. x, vim.log.levels.WARN)
    end
end
