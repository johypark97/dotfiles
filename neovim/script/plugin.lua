-- ========================
-- -------- plugin --------
-- ========================

local lazy = require("lazy")

lazy.setup({
    spec = {
        Init.scriptLoader:dofile("script/plugin/blink-cmp.lua"),
        Init.scriptLoader:dofile("script/plugin/conform.lua"),
        Init.scriptLoader:dofile("script/plugin/gitsigns.lua"),
        Init.scriptLoader:dofile("script/plugin/gruvbox.lua"),
        Init.scriptLoader:dofile("script/plugin/lualine.lua"),
        Init.scriptLoader:dofile("script/plugin/mini-pairs.lua"),
        Init.scriptLoader:dofile("script/plugin/mini-trailspace.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim-treesitter.lua"),
        Init.scriptLoader:dofile("script/plugin/snacks.lua"),

        -- lsp
        Init.scriptLoader:dofile("script/plugin/mason-lspconfig.lua"),
        Init.scriptLoader:dofile("script/plugin/mason.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim-lspconfig.lua"),
    },
})
