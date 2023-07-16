" =========================
" -------- null-ls --------
" =========================

Plug 'jose-elias-alvarez/null-ls.nvim'

" required
Plug 'nvim-lua/plenary.nvim'

function! s:init()
lua << EOF
    local null_ls = require('null-ls')

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.clang_format,
        },
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
