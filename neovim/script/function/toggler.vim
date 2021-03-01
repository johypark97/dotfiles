" =========================
" -------- toggler --------
" =========================

" -------- private --------

function! s:getToggler_guide()
    let l:x = 1
    function! s:Toggle() closure
        let l:x = !l:x
        if l:x
            ALEEnableBuffer
            GitGutterBufferEnable
            " if &filetype != 'json'
                " IndentLinesEnable
                " LeadingSpaceEnable
            " endif

            setlocal list
            setlocal number
            setlocal signcolumn=yes
        else
            ALEDisableBuffer
            GitGutterBufferDisable
            " if &filetype != 'json'
                " IndentLinesDisable
                " LeadingSpaceDisable
            " endif

            setlocal nolist
            setlocal nonumber
            setlocal signcolumn=no
        endif
        echo 'Guide:' l:x
    endfunction
    return funcref('s:Toggle')
endfunction

function! s:getToggler_git()
    let l:x = 0
    function! s:Toggle() closure
        let l:x = !l:x
        if l:x
            GitGutterLineHighlightsEnable
            GitGutterLineNrHighlightsEnable
        else
            GitGutterLineHighlightsDisable
            GitGutterLineNrHighlightsDisable
        endif
        echo 'GitGutterLine:' l:x
    endfunction
    return funcref('s:Toggle')
endfunction

" -------- public --------

function! g:Init_newToggler()
    if !exists('b:init_toggler')
        let b:toggler = {
            \ 'git': s:getToggler_git(),
            \ 'guide': s:getToggler_guide(),
        \ }
    endif
endfunction
