-- ========================
-- -------- plugin --------
-- ========================

local lazy = require("lazy")

lazy.setup({
    spec = {
        -- vim
        Init.scriptLoader:dofile("script/plugin/vim/gruvbox.lua"),
        Init.scriptLoader:dofile("script/plugin/vim/vim-bbye.lua"),
        Init.scriptLoader:dofile("script/plugin/vim/vim-better-whitespace.lua"),
        Init.scriptLoader:dofile("script/plugin/vim/vim-easy-align.lua"),
        Init.scriptLoader:dofile("script/plugin/vim/vim-easymotion.lua"),
        Init.scriptLoader:dofile("script/plugin/vim/vim-vsnip.lua"),

        -- nvim
        Init.scriptLoader:dofile("script/plugin/nvim/gitsigns.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/indent-blankline.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/lualine.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/none-ls.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-autopairs.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-cmp.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-luapad.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-tree.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-treesitter.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/telescope-file-browser.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/telescope.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/trouble.lua"),

        -- lsp
        Init.scriptLoader:dofile("script/plugin/nvim/mason-lspconfig.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/mason.lua"),
        Init.scriptLoader:dofile("script/plugin/nvim/nvim-lspconfig.lua"),
    },
})

-- Init.postInitializer:initialize()
