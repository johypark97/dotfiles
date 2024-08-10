-- ===========================
-- -------- vim-vsnip --------
-- ===========================

-- optional: "rafamadriz/friendly-snippets"

return {
    "hrsh7th/vim-vsnip",
    dependencies = { "hrsh7th/vim-vsnip-integ" },
    init = function()
        vim.g.vsnip_extra_mapping = false
    end,
}
