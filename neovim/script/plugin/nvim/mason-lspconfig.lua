-- =================================
-- -------- mason-lspconfig --------
-- =================================

local function createConfig()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    return {
        capabilities = cmp_nvim_lsp.default_capabilities(),
    }
end

return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            "bashls",
            "lua_ls",
        },
    },
    config = function(_, opts)
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup(opts)

        -- setup lsp servers
        do
            local lspconfig = require("lspconfig")
            local mason_registry = require("mason-registry")

            local serverList = {
                "clangd",
            }

            -- find all installed lsp servers
            for _, installedPackage in ipairs(mason_registry.get_installed_packages()) do
                repeat
                    local spec = installedPackage.spec
                    if spec == nil then
                        break
                    end

                    local categoryList = spec.categories
                    if categoryList[1] ~= "LSP" then
                        break
                    end

                    local server = spec.neovim.lspconfig
                    table.insert(serverList, server)
                until true
            end

            for _, server in ipairs(serverList) do
                lspconfig[server].setup(createConfig())
            end
        end
    end,
}
