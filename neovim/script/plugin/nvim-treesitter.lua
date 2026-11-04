-- =================================
-- -------- nvim-treesitter --------
-- =================================

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local nvim_treesitter = require("nvim-treesitter")

        nvim_treesitter.install({
            "bash",
            "javascript",
            "python",
            "rust",
            "typescript",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "c",
                "javascript",
                "python",
                "rust",
                "sh",
                "typescript",
            },
            callback = function() vim.treesitter.start() end,
        })
    end,
}
