-- ===========================
-- -------- lsp-setup --------
-- ===========================

local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

local function createDefaultConfig()
    return {
        -- Connect the nvim-cmp to the LSP servers
        capabilities = cmp_nvim_lsp.default_capabilities(),
    }
end

-- -------- mason lsp setup --------

mason_lspconfig.setup_handlers({
    function (server)
        lspconfig[server].setup(createDefaultConfig())
    end,
})

-- -------- local lsp setup --------

local serverList = {
    'clangd',
}

for _, server in ipairs(serverList) do
    lspconfig[server].setup(createDefaultConfig())
end
