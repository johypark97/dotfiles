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
"         Alt (M) is case-sensitive

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
    inoremap <C-V> <C-R>+
endif

let mapleader = ','
set pastetoggle=<C-Bslash>

tnoremap <Esc> <C-Bslash><C-N>

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
nnoremap <S-Up>    <C-W>-
nnoremap <S-Down>  <C-W>+
nnoremap <S-Left>  <C-W><
nnoremap <S-Right> <C-W>>

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
cnoremap <M-BS> <C-W>
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

" ========================================
" -------- mappping - MapSwitcher --------
" ========================================

call MapSwitcher_init('<M-Bslash>', MapSwitcher_newMapTable(
    \ MapSwitcher_newPreset('default',
        \ MapSwitcher_newKey('<F8>',         1, 1, '<Cmd>NERDTreeToggle<CR>'),
        \ MapSwitcher_newKey('<Leader><F8>', 1, 1, '<Cmd>NERDTreeVCS<CR>'),
        \ MapSwitcher_newKey('<F9>',         1, 1, '<Cmd>Tagbar<CR>'),
        \ MapSwitcher_newKey('<F10>',        1, 1, '<Cmd>call b:toggler.git()<CR>'),
        \ MapSwitcher_newKey('<F11>',        1, 1, '<Cmd>call b:toggler.guide()<CR>')
    \ ),
    \ MapSwitcher_newPreset('color',
        \ MapSwitcher_newKey('<F9>',  1, 1, '<Cmd>call Init_changeGruvboxBackground()<CR>'),
        \ MapSwitcher_newKey('<F10>', 1, 1, '<Cmd>call Init_changeGruvboxContrast()<CR>'),
        \ MapSwitcher_newKey('<F11>', 1, 1, '<Cmd>call Init_cycleGruvboxColor()<CR>')
    \ )
\ ))

nnoremap <silent> <Bslash><F12>    <Cmd>call MapSwitcher_switch()<CR>
nnoremap <silent> <Bslash><Bslash> <Cmd>call MapSwitcher_help()<CR>
autocmd BufEnter * call Init_newToggler()
