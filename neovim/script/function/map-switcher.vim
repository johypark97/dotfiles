" =============================
" -------- MapSwitcher --------
" =============================

" -------- private --------

function! s:checkVariable()
    let l:prefix = 'g:MapSwitcher_'
    for i in ['executor', 'index', 'mapTable']
        if !exists(l:prefix . i)
            throw l:prefix . i . ' is not defined'
        endif
    endfor
endfunction

function! s:getRhs(key)
    return ":call MapSwitcher_key('" . substitute(a:key, '<', '<lt>', 'g') . "')<CR>"
endfunction

" -------- public --------

function! g:MapSwitcher_map()
    let g:MapSwitcher_index = 0

    try
        call s:checkVariable()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:key = {}
    for i in g:MapSwitcher_mapTable
        for j in keys(i.map)
            call extend(l:key, { j: v:null })
        endfor
    endfor
    let l:key = sort(keys(l:key))

    for i in l:key
        " maparg(i, 'n') converts the <> notation and cause the map fails
        let l:temp = get(maparg(i, 'n', 0, 1), 'rhs', '')
        if l:temp ==# ''
            execute 'nnoremap <unique> <silent>' i s:getRhs(i)
        elseif l:temp !=# s:getRhs(i)
            echoerr 'MapSwitcher_map() failed: cannot map to' i '(' l:temp ')'
        endif
    endfor
endfunction

function! g:MapSwitcher_switch()
    try
        call s:checkVariable()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let g:MapSwitcher_index += 1
    if g:MapSwitcher_index >= len(g:MapSwitcher_mapTable)
        let g:MapSwitcher_index = 0
    endif

    let l:index = 'g:MapSwitcher_index'
    let l:table = 'g:MapSwitcher_mapTable'
    echo printf('MapSwitcher(%d/%d): %s', {l:index} + 1, len({l:table}), {l:table}[{l:index}].name)
endfunction

function! g:MapSwitcher_help()
    try
        call s:checkVariable()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:index = 'g:MapSwitcher_index'
    let l:table = 'g:MapSwitcher_mapTable'

    let l:currentMap = {l:table}[{l:index}]
    let l:keyStringLength = max(map(keys(l:currentMap.map), 'strlen(v:val)'))

    echo '[' l:currentMap.name ']'
    for [key, value] in items(l:currentMap.map)
        echo printf('%*s: %s', l:keyStringLength, key, value.rhs)
    endfor
endfunction

function! g:MapSwitcher_key(key)
    try
        call s:checkVariable()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:index = 'g:MapSwitcher_index'
    let l:table = 'g:MapSwitcher_mapTable'
    let l:function = get({l:table}[{l:index}].map, a:key, {})

    if !empty(l:function)
        let l:command = l:function.isNore ? 'nnoremap' : 'nmap'
        let l:command .= ' <buffer>'
        let l:command .= l:function.isSilent ? ' <silent>' : ''
        let l:command .= ' ' . g:MapSwitcher_executor
        let l:command .= ' ' . l:function.rhs
        execute l:command

        let l:key = '"' . escape(g:MapSwitcher_executor, '<') . '"'
        execute 'normal' eval(l:key)
    endif
endfunction
