" ============================
" -------- indentline --------
" ============================

Plug 'yggdroot/indentline'

" let g:indentLine_leadingSpaceChar = '.'
" let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_bufNameExclude = ['LICENSE.*', 'terminal'] " terminal only works here
let g:indentLine_bufTypeExclude = ['help']
let g:indentLine_char = '¦' " it doesn't apply to the first indet line
let g:indentLine_conceallevel = 1
let g:indentLine_fileTypeExclude = ['json']
let g:indentLine_indentLevel = 16
let g:indentLine_maxLines = 1024
let g:indentLine_setConceal = 1
let g:indentLine_showFirstIndentLevel = 1

" disable leading space when shiftwidth is lower then 4
" autocmd CursorHold * if &shiftwidth < 4 | LeadingSpaceDisable | endif

" show quotes in json file - not necessary because of the fileTypeExclude option and &filetype checking
" autocmd FileType json autocmd CursorHold <buffer> if &conceallevel | setlocal conceallevel=0 | endif
