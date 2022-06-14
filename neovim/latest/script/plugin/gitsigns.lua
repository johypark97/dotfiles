-- ==========================
-- -------- gitsigns --------
-- ==========================

return {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup({
            signs = {
                add    = { text = '+' },
                change = { text = '+' },
            },
            keymaps = {},
        })
    end,
}
