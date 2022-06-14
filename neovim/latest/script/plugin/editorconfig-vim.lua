-- ==================================
-- -------- editorconfig-vim --------
-- ==================================

return {
    'editorconfig/editorconfig-vim',
    config = function()
        vim.cmd('autocmd FileType gitcommit EditorConfigDisable')
    end,
}
