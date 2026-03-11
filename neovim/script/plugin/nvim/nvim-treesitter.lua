-- =================================
-- -------- nvim-treesitter --------
-- =================================

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local nvim_treesitter = require("nvim-treesitter")
        nvim_treesitter.install({ "lua", "vimdoc" })
    end,
}
