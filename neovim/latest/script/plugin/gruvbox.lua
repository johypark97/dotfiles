-- =========================
-- -------- gruvbox --------
-- =========================

return {
    'morhetz/gruvbox',
    config = function()
        vim.g.gruvbox_contrast_dark = 'hard'
        vim.g.gruvbox_contrast_light = 'soft'
        vim.g.gruvbox_invert_selection = 0
        vim.g.gruvbox_invert_signs = 1
    end,
}
