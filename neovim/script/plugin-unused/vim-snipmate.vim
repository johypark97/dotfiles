" ==============================
" -------- vim-snipmate --------
" ==============================

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

let g:snips_no_mappings = 1
let g:snipMate = get(g:, 'snipMate', {})
let g:snipMate.snippet_version = 1

" inoremap          <expr> <C-J>   pumvisible() ? '<C-N>' : '<C-J>'
" inoremap          <expr> <C-K>   pumvisible() ? '<C-P>' : '<C-K>'
" inoremap <silent> <expr> <Tab>   pumvisible() ? '<C-N>' : '<C-R>=snipMate#TriggerSnippet()<CR>'
" inoremap <silent> <expr> <S-Tab> pumvisible() ? '<C-P>' : '<C-R>=snipMate#BackwardsSnippet()<CR>'
" smap                     <Tab>   <Plug>snipMateNextOrTrigger
" smap                     <S-Tab> <Plug>snipMateBack
" xmap                     <Tab>   <Plug>snipMateVisual
" imap                     <F12>   <C-G>u<Plug>snipMateShow
