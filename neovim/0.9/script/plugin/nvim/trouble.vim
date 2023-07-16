" =========================
" -------- trouble --------
" =========================

" :lua vim.diagnostic.setqflist()

Plug 'folke/trouble.nvim'

" optional
" Plug 'nvim-tree/nvim-web-devicons'

function! s:init()
lua << EOF
    local trouble = require('trouble')

    trouble.setup({
        fold_closed = '>',
        fold_open = 'v',
        icons = false,
        indent_lines = false,
        use_diagnostic_signs = false,
        signs = {
            error = '[ERROR]',
            hint = '[HINT]',
            information = '[INFO]',
            warning = '[WARNING]',
        },
    })
EOF
endfunction

call g:postInit#add(funcref('s:init'))
