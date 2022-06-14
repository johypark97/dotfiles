-- ===========================
-- -------- vim-vsnip --------
-- ===========================

return {
    'hrsh7th/vim-vsnip',
    requires = { 'rafamadriz/friendly-snippets', opt = true },
    config = function()
        vim.g.vsnip_extra_mapping = false
    end,
}
