" ==========================
" -------- deoplete --------
" ==========================

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('auto_complete', v:false)
" inoremap <expr> <C-J>     deoplete#util#check_popup() ? '<Down>' : '<C-J>'
" inoremap <expr> <C-K>     deoplete#util#check_popup() ? '<Up>'   : '<C-K>'
" inoremap <expr> <CR>      deoplete#util#check_popup() ? '<CR><C-G>u' : '<CR>'
" inoremap <expr> <Esc>     deoplete#util#check_popup() ? deoplete#cancel_popup() : '<Esc>'
" inoremap <expr> <C-Space> deoplete#util#check_popup() ? deoplete#cancel_popup() : '<C-G>u<C-R>=deoplete#manual_complete()<CR>'
