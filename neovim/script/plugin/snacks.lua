-- ========================
-- -------- snacks --------
-- ========================

return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        bufdelete = { enabled = true },
        explorer = { enabled = true },
        indent = {
            enabled = true,
            animate = { enabled = false },
        },
        scratch  = { enabled = true },
    },
    keys = {
        { "<C-q>",     function() Snacks.bufdelete() end,      desc = "Delete Buffer" },
        { "<F8>",      function() Snacks.explorer() end,       desc = "File Explorer" },
        { "<leader>s", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
        { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
}
