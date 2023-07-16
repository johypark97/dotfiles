" ==================================
" -------- indent-blankline --------
" ==================================

Plug 'lukas-reineke/indent-blankline.nvim'

function! s:init()
lua << EOF
    local indent_blankline = require('indent_blankline')

    local lineConfig = {
        show_current_context = true,
        show_current_context_start = true,
    }

    -- local highlightList = { 'IndentGuidesEven', 'IndentGuidesOdd' }
    -- local spaceConfig = {
    --     char = '',
    --     char_highlight_list = highlightList,
    --     show_trailing_blankline_indent = false,
    --     space_char_highlight_list = highlightList,
    -- }

    indent_blankline.setup(lineConfig)
EOF
endfunction

call g:postInit#add(funcref('s:init'))
