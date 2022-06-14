" ========================
" -------- config --------
" ========================

" -------- color --------
set background=dark
set notermguicolors
colorscheme gruvbox

" -------- common --------
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set encoding=utf-8
set fileformats=unix,dos
set history=1024
set title

" -------- tab --------
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4

" -------- indent --------
set autoindent
set smartindent
set smarttab

" -------- advanced --------
if has('nvim-0.4')
    set listchars=tab:\ \ →,nbsp:␣,trail:•,conceal:◦,precedes:⟨,extends:⟩ " ,eol:↲
else
    set listchars=tab:\ →,nbsp:␣,trail:•,conceal:◦,precedes:⟨,extends:⟩ " ,eol:↲
endif

set cmdheight=2
set colorcolumn=80
set conceallevel=0
set cursorline
set ignorecase
set incsearch
set laststatus=2
set list
set nobackup
set nohidden
set norelativenumber
set notimeout
set nowrap
set number
set numberwidth=5
set ruler
set scrolloff=1
set showbreak=↪\ "
set showcmd
set showmode
set showtabline=2
set sidescrolloff=5
set signcolumn=yes
set smartcase
set splitbelow
set splitright
set updatetime=500
set wildmenu
set writebackup

" -------- filetype --------
autocmd FileType c,cpp setlocal cindent
autocmd FileType html,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
