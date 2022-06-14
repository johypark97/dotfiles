-- ========================
-- -------- config --------
-- ========================

-- -------- color --------
vim.o.background = 'dark'
vim.o.termguicolors = false
vim.cmd('colorscheme gruvbox')

-- -------- common --------
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.o.backspace = 'indent,eol,start'
vim.o.encoding = 'utf-8'
vim.o.fileformats = 'unix,dos'
vim.o.history = 1024
vim.o.title = true

-- -------- tab --------
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- -------- indent --------
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

-- -------- advanced --------
vim.o.backup = false
vim.o.cmdheight = 2
vim.o.colorcolumn = '80'
vim.o.conceallevel = 0
vim.o.cursorline = true
vim.o.hidden = false
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.list = true
vim.o.listchars = 'tab:  →,nbsp:␣,trail:•,conceal:◦,precedes:⟨,extends:⟩' -- ,eol:↲
vim.o.number = true
vim.o.numberwidth = 5
vim.o.relativenumber = false
vim.o.ruler = true
vim.o.scrolloff = 1
vim.o.showbreak = '↪ '
vim.o.showcmd = true
vim.o.showmode = true
vim.o.showtabline = 2
vim.o.sidescrolloff = 5
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeout = false
vim.o.updatetime = 500
vim.o.wildmenu = true
vim.o.wrap = false
vim.o.writebackup = true

-- -------- filetype --------
vim.cmd('autocmd FileType c,cpp setlocal cindent')
vim.cmd('autocmd FileType html,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2')
