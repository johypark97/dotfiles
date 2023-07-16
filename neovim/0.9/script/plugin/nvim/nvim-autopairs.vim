" ================================
" -------- nvim-autopairs --------
" ================================

Plug 'windwp/nvim-autopairs'

function! s:init()
lua << EOF
    local nvim_autopairs = require('nvim-autopairs')

    nvim_autopairs.setup({
        check_ts = true,
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
