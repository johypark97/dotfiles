-- ===============================
-- -------- nerdcommenter --------
-- ===============================

return {
    'preservim/nerdcommenter',
    config = function()
        vim.g.NERDBlockComIgnoreEmpty = 1
        vim.g.NERDCreateDefaultMappings = 0
        vim.g.NERDDefaultAlign = 'left'
        vim.g.NERDRemoveExtraSpaces = 1
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDToggleCheckAllLines = 1
        vim.g.NERDTrimTrailingWhitespace = 1

        vim.g.NERDAltDelims_c = 1
        vim.g.NERDAltDelims_python = 1
    end,
}
