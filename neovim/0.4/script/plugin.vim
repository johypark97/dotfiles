" ========================
" -------- plugin --------
" ========================

let s:vimPlugHome = stdpath('data') . '/plugged'
call plug#begin(s:vimPlugHome)

call Init_sourceScript('script/plugin/ale.vim')
call Init_sourceScript('script/plugin/auto-pairs.vim')
call Init_sourceScript('script/plugin/cmake4vim.vim')
call Init_sourceScript('script/plugin/editorconfig-vim.vim')
call Init_sourceScript('script/plugin/gruvbox.vim')
call Init_sourceScript('script/plugin/nerdcommenter.vim')
call Init_sourceScript('script/plugin/nerdtree.vim')
call Init_sourceScript('script/plugin/tabular.vim')
call Init_sourceScript('script/plugin/tagbar.vim')
call Init_sourceScript('script/plugin/vim-airline.vim')
call Init_sourceScript('script/plugin/vim-bbye.vim')
call Init_sourceScript('script/plugin/vim-better-whitespace.vim')
call Init_sourceScript('script/plugin/vim-dispatch.vim')
call Init_sourceScript('script/plugin/vim-easymotion.vim')
call Init_sourceScript('script/plugin/vim-gitgutter.vim')
call Init_sourceScript('script/plugin/vim-indent-guides.vim')
call Init_sourceScript('script/plugin/vim-smoothie.vim')

call plug#end()
