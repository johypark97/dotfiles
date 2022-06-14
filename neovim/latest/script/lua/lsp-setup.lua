-- ===========================
-- -------- lsp setup --------
-- ===========================

local args = { ... }
local gInit = args[1]

-- -------- setup null-ls --------
if gInit.isLoaded('null-ls.nvim') then
    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            -- null_ls.builtins.formatting.prettier.with({ prefer_local = "node_modules/.bin", }),
            null_ls.builtins.formatting.autopep8,
        }
    })
end

-- -------- install and setup lsp servers --------
if gInit.isLoaded('cmp-nvim-lsp', 'nvim-lsp-installer', 'nvim-lspconfig') then
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local nvim_lsp_installer = require('nvim-lsp-installer')
    local lspconfig = require('lspconfig')

    local servers = {
        { name = 'clangd', autoInstall = false },
        { name = 'pyright', autoInstall = true },

        -- { name = 'jdtls', autoInstall = true },
        -- { name = 'tsserver', autoInstall = true },
    }

    nvim_lsp_installer.setup({})

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

    for _, value in pairs(servers) do
        local serverName = value.name
        local autoInstall = value.autoInstall

        local isAvailable, server = nvim_lsp_installer.get_server(serverName)
        if isAvailable then
            -- install
            if not server:is_installed() and autoInstall then
                server:install()
            end

            -- setup
            local opts = { capabilities = capabilities }

            -- if serverName == 'tsserver' then
            --     opts.on_attach = function(client, bufnr)
            --         client.resolved_capabilities.document_formatting = false
            --     end
            -- end

            lspconfig[serverName].setup(opts)
        end
    end
end
