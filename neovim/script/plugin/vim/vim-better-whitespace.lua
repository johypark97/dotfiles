-- =======================================
-- -------- vim-better-whitespace --------
-- =======================================

return {
    "ntpeters/vim-better-whitespace",
    lazy = false,
    init = function()
        vim.g.better_whitespace_operator = ""
        vim.g.show_spaces_that_precede_tabs = true
        vim.g.strip_max_file_size = false
        vim.g.strip_whitelines_at_eof = true
        vim.g.strip_whitespace_confirm = false
        vim.g.strip_whitespace_on_save = true
    end,
    keys = {
        { "<Leader>w", "<Cmd>StripWhitespace<CR>" },
    },
}
