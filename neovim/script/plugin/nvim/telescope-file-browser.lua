-- ========================================
-- -------- telescope-file-browser --------
-- ========================================

return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local telescope = require("telescope")

        telescope.load_extension("file_browser")
    end,
    keys = {
        { "<Leader>tt", "<Cmd>Telescope file_browser<CR>" },
    },
}
