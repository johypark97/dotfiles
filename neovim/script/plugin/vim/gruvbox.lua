-- =========================
-- -------- gruvbox --------
-- =========================

return {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    init = function()
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_contrast_light = "soft"
        vim.g.gruvbox_invert_selection = false
        vim.g.gruvbox_invert_signs = true
    end,
    config = function()
        vim.cmd("colorscheme gruvbox")
    end,
}
