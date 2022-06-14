-- ==================================
-- -------- indent-blankline --------
-- ==================================

return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        local indentChar = ''
        local indentHighlight = {}

        if true then
            indentChar = '│'
        else
            indentHighlight = { 'IndentGuidesEven', 'IndentGuidesOdd' }
        end

        vim.g.indent_blankline_bufname_exclude = { 'LICENSE.*' }
        vim.g.indent_blankline_buftype_exclude = { 'help', 'terminal' }
        vim.g.indent_blankline_char = indentChar
        vim.g.indent_blankline_disable_with_nolist = true
        vim.g.indent_blankline_filetype_exclude = { 'packer' }
        vim.g.indent_blankline_indent_level = 16
        vim.g.indent_blankline_max_indent_increase = 2
        vim.g.indent_blankline_show_trailing_blankline_indent = false
        vim.g.indent_blankline_space_char_blankline = ' '
        vim.g.indent_blankline_space_char_blankline_highlight_list = indentHighlight
        vim.g.indent_blankline_space_char_highlight_list = indentHighlight
        vim.g.indent_blankline_viewport_buffer = 0
    end,
}
