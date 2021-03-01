" ==================================
" -------- mapping - plugin --------
" ==================================

nnoremap <silent> <C-Q>     <Cmd>Bwipeout<CR>
nnoremap          <Leader>w <Cmd>StripWhitespace<CR>
nnoremap          <M-f>     <Cmd>ALEFix<CR>

nmap <Leader><Space> <Plug>(ale_detail)
nmap <Leader><Tab>   <Plug>(ale_next)
nmap <Leader><S-Tab> <Plug>(ale_previous)

nmap <Leader>ca <Plug>NERDCommenterAltDelims
nmap <Leader>cc <Plug>NERDCommenterToggle
xmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>cC <Plug>NERDCommenterComment
xmap <Leader>cC <Plug>NERDCommenterComment
nmap <Leader>cU <Plug>NERDCommenterUncomment
xmap <Leader>cU <Plug>NERDCommenterUncomment

nmap <Leader>g<Space> <Plug>(GitGutterPreviewHunk)
nmap <Leader>g<Tab>   <Plug>(GitGutterNextHunk)
nmap <Leader>g<S-Tab> <Plug>(GitGutterPrevHunk)

nnoremap <Leader>T/    :Tabularize /
nnoremap <Leader>T<CR> <Cmd>Tabularize<CR>
xnoremap <Leader>T/    :Tabularize /
xnoremap <Leader>T<CR> <Cmd>Tabularize<CR>

nmap <Leader><Leader>w        <Plug>(easymotion-w)
nmap <Leader><Leader>W        <Plug>(easymotion-W)
nmap <Leader><Leader>e        <Plug>(easymotion-e)
nmap <Leader><Leader>E        <Plug>(easymotion-E)
nmap <Leader><Leader>b        <Plug>(easymotion-b)
nmap <Leader><Leader>B        <Plug>(easymotion-B)
nmap <Leader><Leader>j        <Plug>(easymotion-j)
nmap <Leader><Leader>k        <Plug>(easymotion-k)
nmap <Leader><Leader>n        <Plug>(easymotion-n)
nmap <Leader><Leader>N        <Plug>(easymotion-N)
nmap <Leader><Leader>/        <Plug>(easymotion-sn)
nmap <Leader><Leader><Leader> <Plug>(easymotion-jumptoanywhere)

nnoremap <Leader>CM <Cmd>CMake<CR>
nnoremap <Leader>CB <Cmd>CMakeBuild<CR>
nnoremap <Leader>CR <Cmd>CMakeRun<CR>
nnoremap <Leader>CT <Cmd>CTest<CR>
