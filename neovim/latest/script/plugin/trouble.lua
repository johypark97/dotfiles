-- =========================
-- -------- trouble --------
-- =========================

return {
    'folke/trouble.nvim',
    requires = { 'folke/lsp-colors.nvim', opt = true },
    config = function()
        local trouble = require('trouble')
        trouble.setup({
            icons = false,
            fold_open = 'v',
            fold_closed = '>',
            indent_lines = false,
            use_diagnostic_signs = false,
            signs = {
                error = '[ERROR]',
                hint = '[HINT]',
                information = '[INFO]',
                warning = '[WARNING]',
            },
        })
    end,
}
