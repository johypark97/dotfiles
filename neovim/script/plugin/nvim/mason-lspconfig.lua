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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
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

            -- mason servers
            mason_lspconfig.setup_handlers({
                function(server)
                    lspconfig[server].setup(createConfig())
                end,
            })

            -- local servers
            local serverList = {
                "clangd",
            }
            for _, server in ipairs(serverList) do
                lspconfig[server].setup(createConfig())
            end
        end
    end,
}
