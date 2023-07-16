" ===========================
" -------- nvim-tree --------
" ===========================

Plug 'nvim-tree/nvim-tree.lua'

" optional
" Plug 'nvim-tree/nvim-web-devicons'

function! s:init()
lua << EOF
    local nvim_tree = require('nvim-tree')

    nvim_tree.setup({
        renderer = {
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                    modified = false,
                },
            },
        },
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
