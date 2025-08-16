-- =================================
-- -------- mason-lspconfig --------
-- =================================

local function setup(localLspServerList, manualInstallPackageList)
    local MESSAGE = "The following packages require manual installation. Please install using Mason."

    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_registry = require("mason-registry")

    -- a set of lspconfig keys for the lsp server to set up
    local lspconfigNameSet = Init.Set.fromList(localLspServerList)

    -- a set of packages that should be installed manually
    local manualInstallPackageSet = Init.Set.fromList(manualInstallPackageList)

    -- loop
    for _, installedPackage in pairs(mason_registry.get_installed_packages()) do
        -- find the lspconfig name of all lsp servers installed by mason
        if Init.Set.fromList(installedPackage.spec.categories):contains("LSP") then
            lspconfigNameSet:add(installedPackage.spec.neovim.lspconfig)
        end

        -- verify that the packages specified in the manualInstallPackageSet are installed
        manualInstallPackageSet:remove(installedPackage.name)
    end

    -- setup lsp servers
    for _, x in pairs(lspconfigNameSet:toList()) do
        vim.lsp.config(x, {
            capabilities = cmp_nvim_lsp.default_capabilities(),
        })
    end

    -- start the local lsp servers
    for _, x in pairs(localLspServerList) do
        vim.lsp.enable(x)
    end

    -- print a manual installation message if some packages are not installed
    if not manualInstallPackageSet:isEmpty() then
        print(MESSAGE)
        for _, x in pairs(manualInstallPackageSet:toList()) do
            print("- " .. x)
        end
    end
end

return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            "bashls",
            "lua_ls",
            "pyright",
        },
    },
    config = function(_, opts)
        local mason_lspconfig = require("mason-lspconfig")

        -- setup mason-lspconfig
        mason_lspconfig.setup(opts)

        -- setup packages
        local localLspServerList = {
            "clangd",
        }

        local manualInstallPackageList = {
            "black",
        }

        setup(localLspServerList, manualInstallPackageList)
    end,
}
