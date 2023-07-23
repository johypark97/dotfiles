" ========================
" -------- plugin --------
" ========================

call g:postInit#reset()

" let s:vimPlugHome = stdpath('data') . '/plugged'
" call g:plug#begin(s:vimPlugHome)
call g:plug#begin()

" -------- vim plugins --------
call g:init#sourceScript('script/plugin/vim/cmake4vim.vim')
call g:init#sourceScript('script/plugin/vim/editorconfig-vim.vim')
call g:init#sourceScript('script/plugin/vim/gruvbox.vim')
call g:init#sourceScript('script/plugin/vim/tabular.vim')
call g:init#sourceScript('script/plugin/vim/tagbar.vim')
call g:init#sourceScript('script/plugin/vim/vim-bbye.vim')
call g:init#sourceScript('script/plugin/vim/vim-better-whitespace.vim')
call g:init#sourceScript('script/plugin/vim/vim-easymotion.vim')
call g:init#sourceScript('script/plugin/vim/vim-smoothie.vim')

" -------- neovim plugins --------
call g:init#sourceScript('script/plugin/nvim/gitsigns.vim')
call g:init#sourceScript('script/plugin/nvim/indent-blankline.vim')
call g:init#sourceScript('script/plugin/nvim/lualine.vim')
call g:init#sourceScript('script/plugin/nvim/null-ls.vim')
call g:init#sourceScript('script/plugin/nvim/nvim-luapad.vim')
call g:init#sourceScript('script/plugin/nvim/nvim-tree.vim')
call g:init#sourceScript('script/plugin/nvim/nvim-treesitter.vim')
call g:init#sourceScript('script/plugin/nvim/trouble.vim')
call g:init#sourceScript('script/plugin/nvim/vim-vsnip.vim')

" -------- plugins including key mapping --------
call g:init#sourceScript('script/plugin/nvim/comment.vim')
call g:init#sourceScript('script/plugin/nvim/nvim-autopairs.vim')
call g:init#sourceScript('script/plugin/nvim/nvim-cmp.vim')
call g:init#sourceScript('script/plugin/nvim/telescope.vim')

" -------- lsp --------
call g:init#sourceScript('script/plugin/nvim/nvim-lspconfig.vim')  " 0
call g:init#sourceScript('script/plugin/nvim/mason.vim')           " 1
call g:init#sourceScript('script/plugin/nvim/mason-lspconfig.vim') " 2

call g:plug#end()

call g:postInit#run()
call g:init#sourceScript('script/plugin/lua/lsp-setup.lua')
