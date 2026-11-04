-- =========================
-- -------- mapping --------
-- =========================

-- :help key-notation
-- :help map-arguments
-- :help map-which-keys
-- :help script-local

-- combinations
--   Ctrl (C) / Alt (A) / Shift (S)
--   <C- ... > <A- ... > <S- ... >
--     - Ctrl + character = <C- (lowercase) >
--     - Ctrl + Shift + character = <C- (uppercase) >
--     - Alt is case-sensitive

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

vim.g.mapleader = " "

vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>")

vim.keymap.set({ "n", "i", "x", "s" }, "<A-q>", "<Esc>")

vim.keymap.set("i", "<A-h>", "<Left>")
vim.keymap.set("i", "<A-j>", "<Down>")
vim.keymap.set("i", "<A-k>", "<Up>")
vim.keymap.set("i", "<A-l>", "<Right>")

vim.keymap.set("n", "<A-H>",     "<S-Left>",  { remap = true })
vim.keymap.set("n", "<A-J>",     "<S-Down>",  { remap = true })
vim.keymap.set("n", "<A-K>",     "<S-Up>",    { remap = true })
vim.keymap.set("n", "<A-L>",     "<S-Right>", { remap = true })
vim.keymap.set("n", "<S-Up>",    "<C-w>-")
vim.keymap.set("n", "<S-Down>",  "<C-w>+")
vim.keymap.set("n", "<S-Left>",  "<C-w><")
vim.keymap.set("n", "<S-Right>", "<C-w>>")

vim.keymap.set("n", "<Leader>/", "<Cmd>nohlsearch<CR>")

vim.keymap.set("n", "<Leader>b", "<Cmd>buffers<CR>")
vim.keymap.set("n", "<Leader>n", "<Cmd>enew<CR>")
vim.keymap.set("n", "<Leader>l", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>bprevious<CR>")

vim.keymap.set("n", "<Leader><Tab>t", "<Cmd>tabs<CR>")
vim.keymap.set("n", "<Leader><Tab>n", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<Leader><Tab>q", "<Cmd>tabclose<CR>")
vim.keymap.set("n", "<Leader><Tab>l", "gt")
vim.keymap.set("n", "<Leader><Tab>h", "gT")

vim.keymap.set("c", "<A-h>", "<Left>",  { remap = true })
vim.keymap.set("c", "<A-j>", "<Down>",  { remap = true })
vim.keymap.set("c", "<A-k>", "<Up>",    { remap = true })
vim.keymap.set("c", "<A-l>", "<Right>", { remap = true })
vim.keymap.set("c", "<A-b>", "<S-Left>")
vim.keymap.set("c", "<A-f>", "<S-Right>")

vim.cmd("set wildcharm=<C-z>")
vim.keymap.set("c", "<Up>",    function() return vim.fn.wildmenumode() == 1 and "<Left>"     or "<Up>"    end, { expr = true })
vim.keymap.set("c", "<Down>",  function() return vim.fn.wildmenumode() == 1 and "<Right>"    or "<Down>"  end, { expr = true })
vim.keymap.set("c", "<Left>",  function() return vim.fn.wildmenumode() == 1 and "<Up>"       or "<Left>"  end, { expr = true })
vim.keymap.set("c", "<Right>", function() return vim.fn.wildmenumode() == 1 and " <BS><C-z>" or "<Right>" end, { expr = true })

vim.keymap.set("n", "<Bslash><BS><BS>", "<Cmd>edit $MYVIMRC<CR>")
vim.keymap.set("n", "<Bslash><BS><CR>", "<Cmd>source $MYVIMRC<CR>")

-- ========================================
-- -------- mappping - MapSwitcher --------
-- ========================================

Init.mapSwitcher:setExecutor("<A-Bslash>")
Init.mapSwitcher:addKey("default",    "<F2>",  "<Cmd>lua vim.lsp.buf.rename()<CR>")
Init.mapSwitcher:addKey("default",    "<F9>",  "<Cmd>lua vim.lsp.buf.hover()<CR>")
Init.mapSwitcher:addKey("default",    "<F10>", "<Cmd>lua vim.lsp.buf.references()<CR>")
Init.mapSwitcher:addKey("default",    "<F11>", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
Init.mapSwitcher:addKey("default",    "<F12>", "<Cmd>lua vim.lsp.buf.definition()<CR>")
Init.mapSwitcher:addKey("appearance", "<F12>", "<Cmd>lua Init.toggler:toggleGuide()<CR>")
Init.mapSwitcher:apply()

vim.keymap.set("n", "<Bslash><CR>",     "<Cmd>lua Init.mapSwitcher:switchPreset()<CR>")
vim.keymap.set("n", "<Bslash><Bslash>", "<Cmd>lua Init.mapSwitcher:help()<CR>")

-- ====================================
-- -------- mappping - Toggler --------
-- ====================================

Init.toggler:addCallback(function(bufferNumber, enabled)
    vim.b[bufferNumber].snacks_indent = enabled
end)
