-- ===================================
-- -------- mappping - common --------
-- ===================================

-- :help key-notation
-- :help map-arguments
-- :help map-which-keys
-- :help script-local

-- combinations
--   Ctrl (C) / Alt (M) / Shift (S)
--   <C- ... > <M- ... > <S- ... >
--         Alt (M) is case-sensitive

-- special keys
--   <Leader>
--   <F1> - <F12>
--   <Up> <Down> <Left> <Right>
--   <BS> <Bar> <Bslash> <CR> <Esc> <Nul> <Space> <Tab>
--   <Del> <End> <Home> <Insert> <PageDown> <PageUp>

-- special arguments
--   <buffer> <expr> <silent> <unique>

-- etc.
--   <Cmd>
--   <SID>

local args = { ... }
local gInit = args[1]

if vim.fn.has('clipboard') then
    vim.cmd('xnoremap <C-X> "+x')
    vim.cmd('xnoremap <C-C> "+y')
    vim.cmd('inoremap <C-V> <C-R>+')
end

vim.g.mapleader = ','
vim.o.pastetoggle = '<C-Bslash>'

vim.cmd('tnoremap <Esc> <C-Bslash><C-N>')

vim.cmd('nnoremap <M-q> <Esc>')
vim.cmd('inoremap <M-q> <Esc>')
vim.cmd('xnoremap <M-q> <Esc>')
vim.cmd('snoremap <M-q> <Esc>')

vim.cmd('inoremap <M-h> <Left>')
vim.cmd('inoremap <M-j> <Down>')
vim.cmd('inoremap <M-k> <Up>')
vim.cmd('inoremap <M-l> <Right>')

vim.cmd('nmap     <M-H>     <S-Left>')
vim.cmd('nmap     <M-J>     <S-Down>')
vim.cmd('nmap     <M-K>     <S-Up>')
vim.cmd('nmap     <M-L>     <S-Right>')
vim.cmd('nnoremap <S-Up>    <C-W>-')
vim.cmd('nnoremap <S-Down>  <C-W>+')
vim.cmd('nnoremap <S-Left>  <C-W><')
vim.cmd('nnoremap <S-Right> <C-W>>')

vim.cmd('nnoremap <silent> <Leader>/ <Cmd>nohlsearch<CR>')

vim.cmd('nnoremap <silent> <Leader>b <Cmd>buffers<CR>')
vim.cmd('nnoremap <silent> <Leader>n <Cmd>enew<CR>')
vim.cmd('nnoremap <silent> <Leader>. <Cmd>bnext<CR>')
vim.cmd('nnoremap <silent> <Leader>m <Cmd>bprevious<CR>')

vim.cmd('nnoremap <silent> <Leader>tt <Cmd>tabs<CR>')
vim.cmd('nnoremap <silent> <Leader>tn <Cmd>tabnew<CR>')
vim.cmd('nnoremap <silent> <Leader>tq <Cmd>tabclose<CR>')
vim.cmd('nnoremap          <Leader>t. gt')
vim.cmd('nnoremap          <Leader>tm gT')

vim.cmd('nnoremap <F12><F12><F12> <Cmd>edit $MYVIMRC<CR>')
vim.cmd('nnoremap <F12><F12><CR>  <Cmd>source $MYVIMRC<CR>')

vim.cmd('cmap     <M-h>  <Left>')
vim.cmd('cmap     <M-j>  <Down>')
vim.cmd('cmap     <M-k>  <Up>')
vim.cmd('cmap     <M-l>  <Right>')
vim.cmd('cnoremap <M-BS> <C-W>')
vim.cmd('cnoremap <M-b>  <S-Left>')
vim.cmd('cnoremap <M-f>  <S-Right>')

vim.cmd('set wildcharm=<C-Z>')
vim.cmd("cnoremap <expr> <Up>    wildmenumode() ? '<Left>'     : '<Up>'")
vim.cmd("cnoremap <expr> <Down>  wildmenumode() ? '<Right>'    : '<Down>'")
vim.cmd("cnoremap <expr> <Left>  wildmenumode() ? '<Up>'       : '<Left>'")
vim.cmd("cnoremap <expr> <Right> wildmenumode() ? ' <BS><C-Z>' : '<Right>'")

-- nnoremap <Leader><Leader><Tab>   <Cmd>%s;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) * 2 - len(submatch(0)) % 2);g<CR>
-- nnoremap <Leader><Leader><S-Tab> <Cmd>%s;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) / 2 + len(submatch(0)) % 2);g<CR>
-- xnoremap <Leader><Leader><Tab>   <Cmd>s ;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) * 2 - len(submatch(0)) % 2);g<CR>
-- xnoremap <Leader><Leader><S-Tab> <Cmd>s ;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) / 2 + len(submatch(0)) % 2);g<CR>

-- ================================
-- -------- mappping - LSP --------
-- ================================

vim.cmd('nnoremap ,lgD  <Cmd>lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap ,lgd  <Cmd>lua vim.lsp.buf.declaration()<CR>')
vim.cmd('nnoremap ,lgi  <Cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap ,lgr  <Cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap ,lgt  <Cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.cmd('nnoremap ,lrn  <Cmd>lua vim.lsp.buf.rename()<CR>')
vim.cmd('nnoremap <M-f> <Cmd>lua vim.lsp.buf.formatting()<CR>')

-- ========================================
-- -------- mappping - MapSwitcher --------
-- ========================================

do
    local ms = gInit.mapSwitcher

    ms:init('<M-Bslash>', ms:newMapTable(
        ms:newPreset('default',
            ms:newKey('<F8>',         true, true, '<Cmd>NERDTreeToggle<CR>'),
            ms:newKey('<Leader><F8>', true, true, '<Cmd>NERDTreeVCS<CR>'),
            ms:newKey('<F9>',         true, true, '<Cmd>Tagbar<CR>'),
            ms:newKey('<F10>',        true, true, '<Cmd>Gitsigns toggle_signs<CR>'),
            ms:newKey('<F11>',        true, true, '<Cmd>lua init.toggler:toggleGuide()<CR>')
        ),
        ms:newPreset('color',
            ms:newKey('<F9>',  true, true, '<Cmd>lua init.gruvboxColor:changeBackground()<CR>'),
            ms:newKey('<F10>', true, true, '<Cmd>lua init.gruvboxColor:changeContrast()<CR>'),
            ms:newKey('<F11>', true, true, '<Cmd>lua init.gruvboxColor:cycle()<CR>')
        )
    ))

    vim.cmd('nnoremap <silent> <Bslash><F12>    <Cmd>lua init.mapSwitcher:switch()<CR>')
    vim.cmd('nnoremap <silent> <Bslash><Bslash> <Cmd>lua init.mapSwitcher:help()<CR>')
end
