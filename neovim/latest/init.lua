-- [neovim]
-- https://neovim.io/
-- https://github.com/neovim/neovim

-- [init.vim / init.lua]
-- linux: ~/.config/nvim/init.*
-- windows: %LOCALAPPDATA%/nvim/init.*
-- echo $MYVIMRC
--   == &runtimepath . '/init.*'
--   == stdpath('config') . '/init.*'

-- [packer]
-- https://github.com/wbthomason/packer.nvim

-- ==============================
-- -------- ScriptLoader --------
-- ==============================

local ScriptLoader = {}

function ScriptLoader:new()
    local instance = {}

    instance.scriptRoot = nil
    do
        local temp = vim.fn.expand('<sfile>')
        temp = vim.fn.resolve(temp)
        temp = vim.fn.fnamemodify(temp, ':p:h')
        instance.scriptRoot = temp
    end

    return setmetatable(instance, { __index = self })
end

function ScriptLoader:require(path)
    local chunk

    local scriptRootPath = self.scriptRoot .. '/?.lua'
    if package.path:find(scriptRootPath, 1, true) then
        chunk = require(path)
    else
        local temp = package.path
        package.path = scriptRootPath .. ';' .. package.path
        chunk = require(path)
        package.path = temp
    end

    return chunk
end

function ScriptLoader:dofile(path)
    return dofile(self.scriptRoot .. '/' .. path)
end

function ScriptLoader:loadfile(path)
    return loadfile(self.scriptRoot .. '/' .. path)
end

function ScriptLoader:addVimPath()
    vim.opt.path:append(self.scriptRoot)
end

-- ========================
-- -------- init ----------
-- ========================

-- set global namespace
init = init or {}
init.name = 'init'

-- load libraries
init.scriptLoader = init.scriptLoader or ScriptLoader:new()
init.packerWrapper = init.packerWrapper or init.scriptLoader:require('libinit/packer-wrapper'):new(init.name .. '.packerWrapper')
init.isLoaded = init.scriptLoader:require('libinit/check-plugin')
init.print = init.scriptLoader:require('libinit/print')

-- add dotfiles/neovim path to vim path
init.scriptLoader:addVimPath()

-- run init
init.packerWrapper:setStartup(init.scriptLoader:loadfile('script/plugin.lua')(init))
init.packerWrapper:setAfter(function()
    -- -------- stage 0 --------
    init.scriptLoader:loadfile('script/lua/lsp-setup.lua')(init)
    init.scriptLoader:loadfile('script/lua/post-plugin-setup.lua')(init)

    -- -------- stage 1 --------
    init.scriptLoader:dofile('script/command.lua')
    init.scriptLoader:dofile('script/config.lua')

    -- -------- stage 2 --------
    init.scriptLoader:loadfile('script/function.lua')(init)

    -- -------- stage 3 --------
    init.scriptLoader:loadfile('script/mapping.lua')(init)
end)
init.packerWrapper:init()
