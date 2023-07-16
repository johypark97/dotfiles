" ==================================
" -------- mapping - plugin --------
" ==================================

imap <expr> <Tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nnoremap <silent> <C-q>     <Cmd>Bwipeout<CR>
nnoremap          <Leader>w <Cmd>StripWhitespace<CR>

nnoremap <Leader><Space> <Cmd>TroubleToggle<CR>

nnoremap <Leader>ff <Cmd>Telescope find_files<CR>
nnoremap <Leader>fg <Cmd>Telescope live_grep<CR>
nnoremap <Leader>fb <Cmd>Telescope buffers<CR>
nnoremap <Leader>fh <Cmd>Telescope help_tags<CR>

nnoremap <silent> <Leader>g<Space> <Cmd>Gitsigns preview_hunk<CR>
nnoremap <silent> <Leader>g<Tab>   <Cmd>Gitsigns next_hunk<CR>
nnoremap <silent> <Leader>g<S-Tab> <Cmd>Gitsigns prev_hunk<CR>

nnoremap <Leader>T/    :Tabularize /
nnoremap <Leader>T<CR> <Cmd>Tabularize<CR>
xnoremap <Leader>T/    :Tabularize /
xnoremap <Leader>T<CR> <Cmd>Tabularize<CR>

nnoremap <Leader><Leader>w        <Plug>(easymotion-w)
nnoremap <Leader><Leader>W        <Plug>(easymotion-W)
nnoremap <Leader><Leader>e        <Plug>(easymotion-e)
nnoremap <Leader><Leader>E        <Plug>(easymotion-E)
nnoremap <Leader><Leader>b        <Plug>(easymotion-b)
nnoremap <Leader><Leader>B        <Plug>(easymotion-B)
nnoremap <Leader><Leader>j        <Plug>(easymotion-j)
nnoremap <Leader><Leader>k        <Plug>(easymotion-k)
nnoremap <Leader><Leader>n        <Plug>(easymotion-n)
nnoremap <Leader><Leader>N        <Plug>(easymotion-N)
nnoremap <Leader><Leader>/        <Plug>(easymotion-sn)
nnoremap <Leader><Leader><Leader> <Plug>(easymotion-jumptoanywhere)

nnoremap <Leader>CM <Cmd>CMake<CR>
nnoremap <Leader>CB <Cmd>CMakeBuild<CR>
nnoremap <Leader>CR <Cmd>CMakeRun<CR>
nnoremap <Leader>CT <Cmd>CTest<CR>
