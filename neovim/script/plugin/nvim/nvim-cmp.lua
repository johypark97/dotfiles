-- ==========================
-- -------- nvim-cmp --------
-- ==========================

local function feedkey(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-vsnip",
        "neovim/nvim-lspconfig",
    },
    event = { "CmdlineEnter", "InsertEnter" },
    opts = function()
        local cmp = require("cmp")

        return {
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
            }, {
                { name = "buffer" },
            }),
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),

                ["<C-Space>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end, { "i" }),

                ["<Esc>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        fallback()
                    end
                end, { "i" }),

                ["<M-j>"] = cmp.mapping.select_next_item(),
                ["<M-k>"] = cmp.mapping.select_prev_item(),

                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),

                ["<C-D>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-U>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-F>"] = cmp.mapping(cmp.mapping.scroll_docs(8), { "i", "c" }),
                ["<C-B>"] = cmp.mapping(cmp.mapping.scroll_docs(-8), { "i", "c" }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if vim.fn["vsnip#available"](1) == 1 then
                        feedkey("<Plug>(vsnip-jump-next)", "")
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if vim.fn["vsnip#jumpable"](-1) == 1 then
                        feedkey("<Plug>(vsnip-jump-prev)", "")
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        }
    end,
    config = function(_, opts)
        local autopairs_cmp = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        cmp.setup(opts)

        cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done())
    end,
}
