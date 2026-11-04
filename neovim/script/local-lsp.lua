-- =====================
-- -------- lsp --------
-- =====================

local list = {
    "clangd",
    "rust_analyzer",
}

for _, x in pairs(list) do
    vim.lsp.enable(x)
end
