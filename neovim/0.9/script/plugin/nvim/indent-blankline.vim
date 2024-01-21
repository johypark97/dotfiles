" ==================================
" -------- indent-blankline --------
" ==================================

Plug 'lukas-reineke/indent-blankline.nvim'

function! s:init()
lua << EOF
    local ibl = require('ibl')

    ibl.setup()
EOF
endfunction

call g:postInit#add(funcref('s:init'))
