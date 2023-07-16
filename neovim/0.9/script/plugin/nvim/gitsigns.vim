" ==========================
" -------- gitsigns --------
" ==========================

Plug 'lewis6991/gitsigns.nvim'

" required
Plug 'nvim-lua/plenary.nvim'

function! s:init()
lua << EOF
    local gitsigns = require('gitsigns')

    gitsigns.setup({
        signs = {
            add    = { text = '+' },
            change = { text = '+' },
        },
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
