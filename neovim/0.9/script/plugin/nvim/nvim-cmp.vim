" ==========================
" -------- nvim-cmp --------
" ==========================

Plug 'hrsh7th/nvim-cmp'

" required
Plug 'neovim/nvim-lspconfig'

" optional
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'

" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/cmp-path'

" for vsnip
Plug 'hrsh7th/cmp-vsnip'

function! s:init()
lua << EOF
    local autopairs_cmp = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')

    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local function feedkey(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    cmp.setup({
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
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),

            ['<C-Space>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end, { 'i' }),

            ['<Esc>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    fallback()
                end
            end, { 'i' }),

            ['<M-h>'] = cmp.mapping.select_prev_item(),
            ['<M-j>'] = cmp.mapping.select_next_item(),
            ['<M-k>'] = cmp.mapping.select_prev_item(),
            ['<M-l>'] = cmp.mapping.select_next_item(),

            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<Left>'] = cmp.mapping.select_prev_item(),
            ['<Right>'] = cmp.mapping.select_next_item(),

            ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(8), { 'i', 'c' }),
            ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-8), { 'i', 'c' }),
        },
    })

    -- Connect the nvim-cmp to nvim-autopairs
    cmp.event:on('confirm_done', autopairs_cmp.on_confirm_done())
EOF
endfunction

call g:postInit#add(funcref('s:init'))
