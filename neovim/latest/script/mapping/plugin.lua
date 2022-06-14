-- ==================================
-- -------- mapping - plugin --------
-- ==================================

local args = { ... }
local gInit = args[1]

vim.cmd('nnoremap <silent> <C-Q>     <Cmd>Bwipeout<CR>')
vim.cmd('nnoremap          <Leader>w <Cmd>StripWhitespace<CR>')

if gInit.isLoaded('trouble.nvim') then
    vim.cmd('nnoremap <Leader><Space> <Cmd>TroubleToggle<CR>')
end

if gInit.isLoaded('nerdcommenter') then
    vim.cmd('nmap <Leader>ca <Plug>NERDCommenterAltDelims')
    vim.cmd('nmap <Leader>cc <Plug>NERDCommenterToggle')
    vim.cmd('xmap <Leader>cc <Plug>NERDCommenterToggle')
    vim.cmd('nmap <Leader>cC <Plug>NERDCommenterComment')
    vim.cmd('xmap <Leader>cC <Plug>NERDCommenterComment')
    vim.cmd('nmap <Leader>cU <Plug>NERDCommenterUncomment')
    vim.cmd('xmap <Leader>cU <Plug>NERDCommenterUncomment')
end

if gInit.isLoaded('gitsigns.nvim') then
    vim.cmd('nnoremap <silent> <Leader>g<Space> <Cmd>Gitsigns preview_hunk<CR>')
    vim.cmd('nnoremap <silent> <Leader>g<Tab>   <Cmd>Gitsigns next_hunk<CR>')
    vim.cmd('nnoremap <silent> <Leader>g<S-Tab> <Cmd>Gitsigns prev_hunk<CR>')
end

if gInit.isLoaded('tabular') then
    vim.cmd('nnoremap <Leader>T/    :Tabularize /')
    vim.cmd('nnoremap <Leader>T<CR> <Cmd>Tabularize<CR>')
    vim.cmd('xnoremap <Leader>T/    :Tabularize /')
    vim.cmd('xnoremap <Leader>T<CR> <Cmd>Tabularize<CR>')
end

if gInit.isLoaded('vim-easymotion') then
    vim.cmd('nmap <Leader><Leader>w        <Plug>(easymotion-w)')
    vim.cmd('nmap <Leader><Leader>W        <Plug>(easymotion-W)')
    vim.cmd('nmap <Leader><Leader>e        <Plug>(easymotion-e)')
    vim.cmd('nmap <Leader><Leader>E        <Plug>(easymotion-E)')
    vim.cmd('nmap <Leader><Leader>b        <Plug>(easymotion-b)')
    vim.cmd('nmap <Leader><Leader>B        <Plug>(easymotion-B)')
    vim.cmd('nmap <Leader><Leader>j        <Plug>(easymotion-j)')
    vim.cmd('nmap <Leader><Leader>k        <Plug>(easymotion-k)')
    vim.cmd('nmap <Leader><Leader>n        <Plug>(easymotion-n)')
    vim.cmd('nmap <Leader><Leader>N        <Plug>(easymotion-N)')
    vim.cmd('nmap <Leader><Leader>/        <Plug>(easymotion-sn)')
    vim.cmd('nmap <Leader><Leader><Leader> <Plug>(easymotion-jumptoanywhere)')
end

if gInit.isLoaded('cmake4vim') then
    vim.cmd('nnoremap <Leader>CM <Cmd>CMake<CR>')
    vim.cmd('nnoremap <Leader>CB <Cmd>CMakeBuild<CR>')
    vim.cmd('nnoremap <Leader>CR <Cmd>CMakeRun<CR>')
    vim.cmd('nnoremap <Leader>CT <Cmd>CTest<CR>')
end
