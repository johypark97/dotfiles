" =================================
" -------- mason-lspconfig --------
" =================================

Plug 'williamboman/mason-lspconfig.nvim'

function! s:init()
lua << EOF
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup()
EOF
endfunction

call g:postInit#add(funcref('s:init'))
