" =================================
" -------- mason-lspconfig --------
" =================================

Plug 'williamboman/mason-lspconfig.nvim'

function! s:init()
lua << EOF
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup()

    mason_lspconfig.setup_handlers({
        function (server)
            lspconfig[server].setup({
                -- Connect the nvim-cmp to the LSP servers
                capabilities = cmp_nvim_lsp.default_capabilities(),
            })
        end,
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
