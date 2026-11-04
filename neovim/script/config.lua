-- ========================
-- -------- config --------
-- ========================

-- -------- appearance --------

-- header
vim.o.showtabline = 2

-- signcolumn
vim.o.number = true
vim.o.numberwidth = 5
vim.o.signcolumn = "yes:2"

-- editor
vim.o.colorcolumn = "80"
vim.o.cursorline = true

vim.o.list = true
vim.o.listchars = "tab:  →,nbsp:␣,trail:•,conceal:◦,precedes:⟨,extends:⟩" -- ,eol:↲
vim.o.showbreak = "↪ "

vim.o.scrolloff = 1
vim.o.sidescrolloff = 5

vim.o.wrap = false

-- footer
vim.o.cmdheight = 2

-- -------- indent --------
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- -------- control --------

-- search
vim.o.ignorecase = true
vim.o.smartcase = true

-- window
vim.o.splitbelow = true
vim.o.splitright = true

-- control
vim.o.mouse = ""
vim.o.timeout = false

-- -------- file --------
vim.g.c_syntax_for_h = true
vim.o.fileformats = "unix,dos"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function() vim.wo.colorcolumn = "50,72" end,
})
