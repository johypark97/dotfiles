-- =========================
-- -------- lualine --------
-- =========================

return {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
        local lualine = require('lualine')
        lualine.setup({
            options = {
                always_divide_middle = true,
                component_separators = { left = '', right = '' },
                disabled_filetypes = {},
                icons_enabled = false,
                section_separators = { left = '', right = '' },
                theme = 'material',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { { 'filename', path = 1 } },
                lualine_c = { 'branch', { 'diff', colored = false }, 'diagnostics' },
                lualine_x = { 'filesize' ,'encoding', 'fileformat' },
                lualine_y = { 'location', 'progress' },
                lualine_z = { 'filetype' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { 'filename' },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { 'filetype' },
                lualine_z = {},
            },
            tabline = {
                lualine_a = { { 'buffers', mode = 2 } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = { 'hostname' },
                lualine_z = { 'tabs' },
            },
            extensions = {
                'nerdtree',
            },
        })
    end,
}
