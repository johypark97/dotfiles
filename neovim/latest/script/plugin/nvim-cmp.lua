-- ==========================
-- -------- nvim-cmp --------
-- ==========================

-- use 'hrsh7th/cmp-cmdline'
-- use 'hrsh7th/cmp-path'

return {
    'hrsh7th/nvim-cmp',
    requires = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-vsnip' },
    },
    config = function()
        local cmp = require('cmp')

        -- -------- disalbe default mapping --------
        do
            local temp = {}
            for key, _ in pairs(cmp.get_config()['mapping']) do
                temp[key] = cmp.config.disable
            end
            cmp.setup({ mapping = temp })
            temp = nil
        end

        -- -------- setup --------
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        local function feedkey(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        end

        cmp.setup({
            completion = {
                -- autocomplete = false,
                completeopt = 'menu,menuone,noinsert',
            },
            snippet = {
                expand = function(args)
                    vim.fn['vsnip#anonymous'](args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
            }, {
                { name = 'buffer' },
            }),
            experimental = {
                ghost_text = false,
                native_menu = false,
            },
            mapping = {
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.fn['vsnip#available'](1) == 1 then
                        feedkey('<Plug>(vsnip-expand-or-jump)', '')
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                        feedkey('<Plug>(vsnip-jump-prev)', '')
                    end
                end, { 'i', 's' }),

                ['<C-Space>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end, { 'i' }),

                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),

                ['<C-Y>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),

                ['<M-h>'] = cmp.mapping.select_prev_item(),
                ['<M-j>'] = cmp.mapping.select_next_item(),
                ['<M-k>'] = cmp.mapping.select_prev_item(),
                ['<M-l>'] = cmp.mapping.select_next_item(),

                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<Left>'] = cmp.mapping.select_prev_item(),
                ['<Right>'] = cmp.mapping.select_next_item(),

                ['<C-N>'] = cmp.mapping.select_next_item(),
                ['<C-P>'] = cmp.mapping.select_prev_item(),

                ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(8), { 'i', 'c' }),
                ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-8), { 'i', 'c' }),
            },
        })

        -- cmp.setup.cmdline('/', {
        --     sources = {
        --         { name = 'buffer' },
        --     },
        -- })

        -- cmp.setup.cmdline(':', {
        --     sources = {
        --         { name = 'path' },
        --         { name = 'cmdline' },
        --     },
        -- })
    end,
}
