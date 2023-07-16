" ==========================
" -------- PostInit --------
" ==========================

" -------- private --------

let s:funcList = v:null

" -------- public --------

function! g:postInit#reset()
    let s:funcList = []
endfunction

function! g:postInit#add(value)
    if type(s:funcList) != v:t_list
        echoerr 'PostInit is not initialized'
    endif

    if type(a:value) != v:t_func
        echoerr 'value is not a function'
    endif

    let s:funcList = add(s:funcList, a:value)
endfunction

function! g:postInit#run()
    for F in s:funcList
        call F()
    endfor
endfunction
