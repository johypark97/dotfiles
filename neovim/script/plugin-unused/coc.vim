" =====================
" -------- coc --------
" =====================

" requirements: nodejs, npm
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-json',
    \ 'coc-pyright',
\ ]

let g:coc_user_config = {
    \ 'diagnostic.displayByAle': 'true',
    \ 'diagnostic.warningSign': 'W',
    \ 'suggest.autoTrigger': 'none',
    \ 'json.schemas': [
        \ {
            \ 'fileMatch': ['.vimspector.json'],
            \ 'url': Init_getVimspectorSchemaPath('vimspector.schema.json')
        \ },
        \ {
            \ 'fileMatch': ['.gadgets.json', '.gadgets.d/*.json'],
            \ 'url': Init_getVimspectorSchemaPath('gadgets.schema.json')
        \ }
    \ ]
\ }

" nnoremap <Leader><Leader><Space> :CocDiagnostics<CR>
" nmap     <Leader>jd              <Plug>(coc-definition)
" nmap     <Leader>jt              <Plug>(coc-type-definition)
" nmap     <Leader>ji              <Plug>(coc-implementation)
" nmap     <Leader>jr              <Plug>(coc-references)

" inoremap          <expr> <C-J>     pumvisible() ? '<Down>' : '<C-J>'
" inoremap          <expr> <C-K>     pumvisible() ? '<Up>'   : '<C-K>'
" inoremap          <expr> <Esc>     pumvisible() ? '<Esc>a' : '<Esc>'
" inoremap <silent> <expr> <C-Space> pumvisible() ? '<Esc>a' : '<C-G>u<C-R>=coc#refresh()<CR>'
" inoremap <silent> <expr> <CR>      pumvisible() ? '<C-R>=coc#_select_confirm()<CR><C-G>u <BS>' : '<CR><C-R>=coc#on_enter()<CR>'
