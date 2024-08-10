-- =========================
-- -------- mapping --------
-- =========================

-- :help key-notation
-- :help map-arguments
-- :help map-which-keys
-- :help script-local

-- combinations
--   Ctrl (C) / Alt (M) / Shift (S)
--   <C- ... > <M- ... > <S- ... >
--     - Ctrl + character = <C- (lowercase) >
--     - Ctrl + Shift + character = <C- (uppercase) >
--     - Alt (M) is case-sensitive

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

if vim.fn.has("clipboard") then
    vim.keymap.set("x", "<C-X>", "\"+x")
    vim.keymap.set("x", "<C-C>", "\"+y")
    vim.keymap.set("i", "<C-V>", "<C-r>+")
end

vim.cmd("set mouse=")
vim.cmd("set pastetoggle=<C-Bslash>")

vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>")

vim.keymap.set({ "n", "i", "x", "s" }, "<M-q>", "<Esc>")

vim.keymap.set("i", "<M-h>", "<Left>")
vim.keymap.set("i", "<M-j>", "<Down>")
vim.keymap.set("i", "<M-k>", "<Up>")
vim.keymap.set("i", "<M-l>", "<Right>")

vim.keymap.set("n", "<M-H>",     "<S-Left>",  { remap = true })
vim.keymap.set("n", "<M-J>",     "<S-Down>",  { remap = true })
vim.keymap.set("n", "<M-K>",     "<S-Up>",    { remap = true })
vim.keymap.set("n", "<M-L>",     "<S-Right>", { remap = true })
vim.keymap.set("n", "<S-Up>",    "<C-w>-")
vim.keymap.set("n", "<S-Down>",  "<C-w>+")
vim.keymap.set("n", "<S-Left>",  "<C-w><")
vim.keymap.set("n", "<S-Right>", "<C-w>>")

vim.keymap.set("n", "<Leader>/", "<Cmd>nohlsearch<CR>")

vim.keymap.set("n", "<Leader>b", "<Cmd>buffers<CR>")
vim.keymap.set("n", "<Leader>n", "<Cmd>enew<CR>")
vim.keymap.set("n", "<Leader>l", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>bprevious<CR>")

vim.keymap.set("n", "<Leader>tt", "<Cmd>tabs<CR>")
vim.keymap.set("n", "<Leader>tn", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<Leader>tq", "<Cmd>tabclose<CR>")
vim.keymap.set("n", "<Leader>tl", "gt")
vim.keymap.set("n", "<Leader>th", "gT")

vim.keymap.set("c", "<M-h>", "<Left>",  { remap = true })
vim.keymap.set("c", "<M-j>", "<Down>",  { remap = true })
vim.keymap.set("c", "<M-k>", "<Up>",    { remap = true })
vim.keymap.set("c", "<M-l>", "<Right>", { remap = true })
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")

-- vim.cmd("set wildcharm=<C-z>")
vim.keymap.set("c", "<Up>",    function() return vim.fn.wildmenumode() == 1 and "<Left>"     or "<Up>"    end, { expr = true })
vim.keymap.set("c", "<Down>",  function() return vim.fn.wildmenumode() == 1 and "<Right>"    or "<Down>"  end, { expr = true })
vim.keymap.set("c", "<Left>",  function() return vim.fn.wildmenumode() == 1 and "<Up>"       or "<Left>"  end, { expr = true })
vim.keymap.set("c", "<Right>", function() return vim.fn.wildmenumode() == 1 and " <BS><C-z>" or "<Right>" end, { expr = true })

vim.keymap.set("n", "<Bslash><BS><BS>", "<Cmd>edit $MYVIMRC<CR>")
vim.keymap.set("n", "<Bslash><BS><CR>", "<Cmd>source $MYVIMRC<CR>")

-- ================================
-- -------- mappping - LSP --------
-- ================================

--[[
vim.lsp.buf.add_workspace_folder()
vim.lsp.buf.clear_references()
vim.lsp.buf.code_action()
vim.lsp.buf.completion()
vim.lsp.buf.declaration()
vim.lsp.buf.definition()
vim.lsp.buf.document_highlight()
vim.lsp.buf.document_symbol()
vim.lsp.buf.execute_command()
vim.lsp.buf.format()
vim.lsp.buf.hover()
vim.lsp.buf.implementation()
vim.lsp.buf.incoming_calls()
vim.lsp.buf.list_workspace_folders()
vim.lsp.buf.outgoing_calls()
vim.lsp.buf.references()
vim.lsp.buf.remove_workspace_folder()
vim.lsp.buf.rename()
vim.lsp.buf.signature_help()
vim.lsp.buf.type_definition()
vim.lsp.buf.typehierarchy()
vim.lsp.buf.typehierarchy()
vim.lsp.buf.workspace_symbol()
]]

vim.keymap.set("n", "<M-f>", "<Cmd>lua vim.lsp.buf.format()<CR>")

-- ========================================
-- -------- mappping - MapSwitcher --------
-- ========================================

Init.mapSwitcher:setExecutor("<M-Bslash>")
Init.mapSwitcher:addKey("default",    "<F2>",    "<Cmd>lua vim.lsp.buf.rename()<CR>")
Init.mapSwitcher:addKey("default",    "<F8>",    "<Cmd>NvimTreeToggle<CR>")
Init.mapSwitcher:addKey("default",    "<F9>",    "<Cmd>lua vim.lsp.buf.hover()<CR>")
Init.mapSwitcher:addKey("default",    "<C-F12>", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
Init.mapSwitcher:addKey("default",    "<S-F12>", "<Cmd>lua vim.lsp.buf.references()<CR>")
Init.mapSwitcher:addKey("default",    "<F12>",   "<Cmd>lua vim.lsp.buf.definition()<CR>")
Init.mapSwitcher:addKey("appearance", "<F9>",    "<Cmd>lua Init.gruvboxColor:changeBackground()<CR>")
Init.mapSwitcher:addKey("appearance", "<F10>",   "<Cmd>lua Init.gruvboxColor:changeContrast()<CR>")
Init.mapSwitcher:addKey("appearance", "<F11>",   "<Cmd>lua Init.gruvboxColor:cycleColor()<CR>")
Init.mapSwitcher:addKey("appearance", "<F12>",   "<Cmd>lua Init.toggler:toggleGuide()<CR>")
Init.mapSwitcher:apply()

vim.keymap.set("n", "<Bslash><CR>",     "<Cmd>lua Init.mapSwitcher:switchPreset()<CR>")
vim.keymap.set("n", "<Bslash><Bslash>", "<Cmd>lua Init.mapSwitcher:help()<CR>")

-- ====================================
-- -------- mappping - Toggler --------
-- ====================================

Init.toggler:addCallback(function(value)
    require("ibl").setup_buffer(0, { enabled = value })
end)
