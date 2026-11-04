-- =================================
-- -------- mason-lspconfig --------
-- =================================

return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            "bashls",
            "eslint",
            "lua_ls",
            "pyright",
        },
    },
}
