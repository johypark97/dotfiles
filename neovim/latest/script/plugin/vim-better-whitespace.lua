-- =======================================
-- -------- vim-better-whitespace --------
-- =======================================

return {
    'ntpeters/vim-better-whitespace',
    config = function()
        vim.g.better_whitespace_operator = ''
        vim.g.show_spaces_that_precede_tabs = 1
        vim.g.strip_max_file_size = 0
        vim.g.strip_whitelines_at_eof = 1
        vim.g.strip_whitespace_confirm = 0
        vim.g.strip_whitespace_on_save = 1
    end,
}
