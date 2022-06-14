-- ========================
-- -------- plugin --------
-- ========================

local args = { ... }
local gInit = args[1]

return function(use, use_rocks)
    use(gInit.scriptLoader:dofile('script/plugin/cmake4vim.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/editorconfig-vim.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/gitsigns.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/gruvbox.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/indent-blankline.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/lualine.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nerdcommenter.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nerdtree.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nvim-luapad.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/tabular.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/tagbar.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/trouble.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-bbye.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-better-whitespace.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-dispatch.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-easymotion.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-smoothie.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/vim-vsnip.lua'))

    -- -------- lsp --------
    -- use(gInit.scriptLoader:dofile('script/plugin/nvim-jdtls.lua'))
    -- use(gInit.scriptLoader:dofile('script/plugin/nvim-lsp-ts-utils.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/null-ls.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nvim-lsp-installer.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nvim-lspconfig.lua'))

    -- -------- plugins including key mapping --------
    use(gInit.scriptLoader:dofile('script/plugin/nvim-autopairs.lua'))
    use(gInit.scriptLoader:dofile('script/plugin/nvim-cmp.lua'))
end
