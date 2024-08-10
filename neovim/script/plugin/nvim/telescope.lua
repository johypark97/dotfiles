-- ===========================
-- -------- telescope --------
-- ===========================

-- optional: "nvim-tree/nvim-web-devicons"

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<Leader>tb", "<Cmd>Telescope buffers<CR>" },
        { "<Leader>tf", "<Cmd>Telescope find_files<CR>" },
        { "<Leader>tg", "<Cmd>Telescope live_grep<CR>" },
        { "<Leader>th", "<Cmd>Telescope help_tags<CR>" },
    },
}
