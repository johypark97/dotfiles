-- ================================
-- -------- nvim-autopairs --------
-- ================================

return {
    'windwp/nvim-autopairs',
    config = function()
        local nvim_autopairs = require('nvim-autopairs')
        nvim_autopairs.setup({
            fast_wrap = {
                map = '<M-e>',
            },
        })
    end,
}
