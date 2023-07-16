" =======================
" -------- mason --------
" =======================

Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }

function! s:init()
lua << EOF
    local mason = require('mason')

    mason.setup()
EOF
endfunction

call g:postInit#add(funcref('s:init'))
