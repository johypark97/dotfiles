-- =========================
-- -------- trouble --------
-- =========================

return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
        { "<Leader>x", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
    },
}
