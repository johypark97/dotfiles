" ===================================
" -------- mappping - common --------
" ===================================

" :help key-notation
" :help map-arguments
" :help map-which-keys
" :help script-local

" combinations
"   Ctrl (C) / Alt (M) / Shift (S)
"   <C- ... > <M- ... > <S- ... >
"     - Ctrl + character = <C- (lowercase) >
"     - Ctrl + Shift + character = <C- (uppercase) >
"     - Alt (M) is case-sensitive

" special keys
"   <Leader>
"   <F1> - <F12>
"   <Up> <Down> <Left> <Right>
"   <BS> <Bar> <Bslash> <CR> <Esc> <Nul> <Space> <Tab>
"   <Del> <End> <Home> <Insert> <PageDown> <PageUp>

" special arguments
"   <buffer> <expr> <silent> <unique>

" etc.
"   <Cmd>
"   <SID>

if has('clipboard')
    xnoremap <C-X> "+x
    xnoremap <C-C> "+y
    inoremap <C-V> <C-r>+
endif

let mapleader = ','
set pastetoggle=<C-Bslash>

tnoremap <Esc> <C-Bslash><C-n>

nnoremap <M-q> <Esc>
inoremap <M-q> <Esc>
xnoremap <M-q> <Esc>
snoremap <M-q> <Esc>

inoremap <M-h>  <Left>
inoremap <M-j>  <Down>
inoremap <M-k>  <Up>
inoremap <M-l>  <Right>

nmap     <M-H>     <S-Left>
nmap     <M-J>     <S-Down>
nmap     <M-K>     <S-Up>
nmap     <M-L>     <S-Right>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>

nnoremap <silent> <Leader>/ <Cmd>nohlsearch<CR>

nnoremap <silent> <Leader>b <Cmd>buffers<CR>
nnoremap <silent> <Leader>n <Cmd>enew<CR>
nnoremap <silent> <Leader>. <Cmd>bnext<CR>
nnoremap <silent> <Leader>m <Cmd>bprevious<CR>

nnoremap <silent> <Leader>tt <Cmd>tabs<CR>
nnoremap <silent> <Leader>tn <Cmd>tabnew<CR>
nnoremap <silent> <Leader>tq <Cmd>tabclose<CR>
nnoremap          <Leader>t. gt
nnoremap          <Leader>tm gT

nnoremap <F12><F12><F12> <Cmd>edit $MYVIMRC<CR>
nnoremap <F12><F12><CR>  <Cmd>source $MYVIMRC<CR>

cmap     <M-h>  <Left>
cmap     <M-j>  <Down>
cmap     <M-k>  <Up>
cmap     <M-l>  <Right>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>

set wildcharm=<C-Z>
cnoremap <expr> <Up>    wildmenumode() ? '<Left>'     : '<Up>'
cnoremap <expr> <Down>  wildmenumode() ? '<Right>'    : '<Down>'
cnoremap <expr> <Left>  wildmenumode() ? '<Up>'       : '<Left>'
cnoremap <expr> <Right> wildmenumode() ? ' <BS><C-Z>' : '<Right>'

" nnoremap <Leader><Leader><Tab>   <Cmd>%s;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) * 2 - len(submatch(0)) % 2);g<CR>
" nnoremap <Leader><Leader><S-Tab> <Cmd>%s;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) / 2 + len(submatch(0)) % 2);g<CR>
" xnoremap <Leader><Leader><Tab>   <Cmd>s ;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) * 2 - len(submatch(0)) % 2);g<CR>
" xnoremap <Leader><Leader><S-Tab> <Cmd>s ;^\(\s\{2,}\);\=repeat(' ', len(submatch(0)) / 2 + len(submatch(0)) % 2);g<CR>

" ================================
" -------- mappping - LSP --------
" ================================

nnoremap <Leader>lgD  <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>lgd  <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>lgi  <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>lgr  <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>lgt  <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>lrn  <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <M-f>        <Cmd>lua vim.lsp.buf.format()<CR>

" ========================================
" -------- mappping - MapSwitcher --------
" ========================================

call g:mapSwitcher#init('<M-Bslash>', g:mapSwitcher#newMapTable(
    \ g:mapSwitcher#newPreset('default',
        \ g:mapSwitcher#newKey('<F8>',  1, 1, '<Cmd>NvimTreeToggle<CR>'),
        \ g:mapSwitcher#newKey('<F9>',  1, 1, '<Cmd>Tagbar<CR>'),
        \ g:mapSwitcher#newKey('<F10>', 1, 1, '<Cmd>Gitsigns toggle_signs<CR>'),
        \ g:mapSwitcher#newKey('<F11>', 1, 1, '<Cmd>call b:Toggler_toggler.guide()<CR>')
    \ ),
    \ g:mapSwitcher#newPreset('color',
        \ g:mapSwitcher#newKey('<F9>',  1, 1, '<Cmd>call g:gruvboxColor#changeBackground()<CR>'),
        \ g:mapSwitcher#newKey('<F10>', 1, 1, '<Cmd>call g:gruvboxColor#changeContrast()<CR>'),
        \ g:mapSwitcher#newKey('<F11>', 1, 1, '<Cmd>call g:gruvboxColor#cycleColor()<CR>')
    \ )
\ ))

nnoremap <silent> <Bslash><F12>    <Cmd>call g:mapSwitcher#switch()<CR>
nnoremap <silent> <Bslash><Bslash> <Cmd>call g:mapSwitcher#help()<CR>
autocmd BufEnter * call g:toggler#newToggler()
