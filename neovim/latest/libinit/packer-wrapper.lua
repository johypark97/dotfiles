-- ================================
-- -------- PackerWrapper --------
-- ================================

-- -------- debug function --------

local DEBUG = false

local function DEBUG_PRINT(...)
    if DEBUG then
        local args = { ... }
        print(table.concat(args, ' '))
    end
end

-- -------- definition --------

local PackerWrapper = {
    -- static variables
    COMPILE_PATH = vim.fn.stdpath('config') .. '/packer_compiled.lua',
    INSTALL_PATH = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim',
    URL = 'https://github.com/wbthomason/packer.nvim',
}

function PackerWrapper:new(globalInstanceName)
    local instance = {}

    instance.callback_after = nil
    instance.callback_startup = nil
    instance.globalInstanceName = globalInstanceName
    instance.stage = 0

    return setmetatable(instance, { __index = self })
end

function PackerWrapper:isInstalled()
    return vim.fn.empty(vim.fn.glob(PackerWrapper.INSTALL_PATH)) == 0
end

function PackerWrapper:isCompiled()
    return vim.fn.empty(vim.fn.glob(PackerWrapper.COMPILE_PATH)) == 0
end

function PackerWrapper:install()
    DEBUG_PRINT('  install()')
    vim.fn.system({ 'git', 'clone', '--depth', '1', PackerWrapper.URL, PackerWrapper.INSTALL_PATH })
end

function PackerWrapper:sync()
    DEBUG_PRINT('  sync()')
    local packer = require('packer')
    packer.sync()
end

function PackerWrapper:loadCompiled()
    DEBUG_PRINT('  loadCompiled()')
    dofile(PackerWrapper.COMPILE_PATH)
end

function PackerWrapper:runStartup()
    DEBUG_PRINT('  runStartup()')
    local packer = require('packer')
    packer.startup({
        function(use, use_rocks)
            use('wbthomason/packer.nvim')

            if type(self.callback_startup) == 'function' then
                self.callback_startup(use, use_rocks)
            end
        end,
        config = {
            auto_reload_compiled = false,
            compile_on_sync = true,
            compile_path = PackerWrapper.COMPILE_PATH,
        },
    })
end

function PackerWrapper:runAfter()
    DEBUG_PRINT('  runAfter()')
    if type(self.callback_after) == 'function' then
        self.callback_after()
    end
end

function PackerWrapper:setStartup(callback)
    self.callback_startup = callback
end

function PackerWrapper:setAfter(callback)
    self.callback_after = callback
end

function PackerWrapper:init()
    local methodName = 'init'

    if self.stage == 0 then
        if not self:isInstalled() then
            self.stage = 1
        elseif not self:isCompiled() then
            self.stage = 2
        else
            self.stage = 3
        end
    end

    DEBUG_PRINT('stage', self.stage)

    if self.stage == 1 then
        self:install()
        self.stage = 2
        -- vim.cmd('autocmd! VimEnter * ++once source $MYVIMRC')
        vim.cmd(string.format('autocmd! VimEnter * ++once lua %s:%s()', self.globalInstanceName, methodName))
    elseif self.stage == 2 then
        self:runStartup()
        self.stage = 3
        -- vim.cmd('autocmd! User PackerCompileDone ++once source $MYVIMRC')
        vim.cmd(string.format('autocmd! User PackerCompileDone ++once lua %s:%s()', self.globalInstanceName, methodName))
        self:sync()
    else
        self:runStartup()
        self:loadCompiled()
        self:runAfter()
    end
end

return PackerWrapper
