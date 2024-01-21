" =========================
" -------- Toggler --------
" =========================

" -------- private --------

let s:funcList = v:null

function! s:getGuideToggler()
    let l:x = &list || &number || &signcolumn == 'yes'

    function! s:toggle() closure
        let l:x = !l:x

        if l:x
            setlocal list
            setlocal number
            setlocal signcolumn=yes
        else
            setlocal nolist
            setlocal nonumber
            setlocal signcolumn=no
        endif

        if s:funcList isnot v:null
            for F in s:funcList
                call F(l:x)
            endfor
        endif
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

function! g:toggler#resetCallback()
    let s:funcList = []
endfunction

function! g:toggler#addCallback(value)
    if type(s:funcList) != v:t_list
        echoerr 'callback is not initialized'
    endif

    if type(a:value) != v:t_func
        echoerr 'value is not a function'
    endif

    let s:funcList = add(s:funcList, a:value)
endfunction
