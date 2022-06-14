-- ================================
-- -------- vim-easymotion --------
-- ================================

return {
    'easymotion/vim-easymotion',
    config = function()
        vim.g.EasyMotion_do_mapping = 0
        vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
        vim.g.EasyMotion_smartcase = 1
        vim.g.EasyMotion_startofline = 0
    end,
}
