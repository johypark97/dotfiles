-- =========================
-- -------- none-ls --------
-- =========================

return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
        local none_ls = require("null-ls")

        return {
            sources = {
                none_ls.builtins.code_actions.gitsigns,
                none_ls.builtins.completion.vsnip,
                none_ls.builtins.formatting.black,
            },
        }
    end,
}
