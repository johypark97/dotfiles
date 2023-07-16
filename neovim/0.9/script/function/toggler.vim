" =========================
" -------- Toggler --------
" =========================

" -------- private --------

function! s:getGuideToggler()
    let l:x = &list || &number || &signcolumn == 'yes'

    function! s:toggle() closure
        if l:x
            setlocal nolist
            setlocal nonumber
            setlocal signcolumn=no
        else
            setlocal list
            setlocal number
            setlocal signcolumn=yes
        endif

        let l:x = !l:x
    endfunction

    return funcref('s:toggle')
endfunction

" -------- public --------

function! g:toggler#newToggler()
    if !exists('b:Toggler_toggler')
        let b:Toggler_toggler = {
            \ 'guide': s:getGuideToggler(),
        \ }
    endif
endfunction
