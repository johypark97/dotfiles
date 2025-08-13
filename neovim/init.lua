-- [neovim]
-- https://neovim.io/
-- https://github.com/neovim/neovim

-- [init.vim / init.lua]
-- linux: ~/.config/nvim/init.*
-- windows: %LOCALAPPDATA%/nvim/init.*
-- echo $MYVIMRC
--     == vim.fn.stdpath("config") .. "/init.*"

if vim.fn.has("nvim-0.11") == 0 then
    error("[init.lua] This version of Neovim is not supported.")
end

-- ==============================
-- -------- ScriptLoader --------
-- ==============================

local ScriptLoader = {}

function ScriptLoader:new()
    local instance = {}

    local path = vim.fn.expand("<sfile>")
    path = vim.fn.resolve(path)
    path = vim.fn.fnamemodify(path, ":p:h")
    instance.scriptRoot = path

    return setmetatable(instance, { __index = self })
end

function ScriptLoader:addLuaPath()
    local pattern = self.scriptRoot .. "/?.lua"

    if not package.path:find(pattern, 1, true) then
        package.path = pattern .. ";" .. package.path
    end
end

function ScriptLoader:addVimPath()
    vim.opt.path:append(self.scriptRoot)
end

function ScriptLoader:dofile(path)
    return dofile(self.scriptRoot .. "/" .. path)
end

function ScriptLoader:loadfile(path)
    return loadfile(self.scriptRoot .. "/" .. path)
end

-- ======================
-- -------- Init --------
-- ======================

Init = Init or {}
Init.name = "Init"
Init.scriptLoader = Init.scriptLoader or ScriptLoader:new()

-- stage 0
Init.scriptLoader:addLuaPath()
Init.scriptLoader:addVimPath()
Init.scriptLoader:dofile("bootstrap_lazy.lua")

-- stage 1
Init.scriptLoader:dofile("script/config.lua")

-- stage 2
Init.scriptLoader:dofile("script/function.lua")

-- stage 3
Init.scriptLoader:dofile("script/autocmd.lua")
Init.scriptLoader:dofile("script/command.lua")
Init.scriptLoader:dofile("script/mapping.lua")
Init.scriptLoader:dofile("script/plugin.lua")
