" =====================
" -------- ale --------
" =====================

Plug 'dense-analysis/ale'

" let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
" let g:init_aleFormaters = {}

let g:ale_disable_lsp = 1

let g:ale_fixers = {
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format'],
\ }

let g:ale_linters = {
    \ 'c': ['clangtidy'],
    \ 'cpp': ['clangtidy'],
    \ 'python': ['pycodestyle'],
\ }
