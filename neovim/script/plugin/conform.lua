-- ==============================
-- -------- conform.nvim --------
-- ==============================

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { "clang_format" },
            javascript = { "prettier" },
            lua = { lsp_format = "fallback" },
            python = { "black" },
            rust = { "rustfmt" },
            typescript = { "prettier" },
        },
    },
    keys = {
        { "<A-f>", function() require("conform").format({ timeout_ms = 8000 }) end }
    },
}
