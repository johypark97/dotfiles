-- =========================
-- -------- trouble --------
-- =========================

-- optional: "nvim-tree/nvim-web-devicons"

return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    keys = {
        { "<Leader>x", "<Cmd>Trouble diagnostics toggle<CR>" },
    },
  }
