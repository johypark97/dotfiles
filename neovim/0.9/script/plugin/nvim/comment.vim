" =========================
" -------- comment --------
" =========================

Plug 'numToStr/Comment.nvim'

function! s:init()
lua << EOF
    local comment = require('Comment')

    comment.setup()
EOF
endfunction

call g:postInit#add(funcref('s:init'))
