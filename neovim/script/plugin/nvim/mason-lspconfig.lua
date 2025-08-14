-- =================================
-- -------- mason-lspconfig --------
-- =================================

local function setupLspServer()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_registry = require("mason-registry")

    local lspServerSet = {
        -- locally installed lsp servers
        ["clangd"] = true,
    }

    -- find all lsp servers installed by mason
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

            local lspconfig = spec.neovim.lspconfig
            lspServerSet[lspconfig] = true
        until true
    end

    for lspServer in pairs(lspServerSet) do
        vim.lsp.config(lspServer, {
            capabilities = cmp_nvim_lsp.default_capabilities(),
        })
    end
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

        -- setup mason-lspconfig
        mason_lspconfig.setup(opts)

        -- setup lsp servers
        setupLspServer()
    end,
}
