-- ==========================
-- -------- gitsigns --------
-- ==========================

return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = true,
    keys = {
        { "<Leader>gg", "<Cmd>Gitsigns preview_hunk<CR>" },
        { "<Leader>gh", "<Cmd>Gitsigns prev_hunk<CR>" },
        { "<Leader>gl", "<Cmd>Gitsigns next_hunk<CR>" },
        { "<Leader>gr", "<Cmd>Gitsigns reset_hunk<CR>" },
        { "<Leader>gs", "<Cmd>Gitsigns stage_hunk<CR>" },
    },
}
