" =============================
" -------- MapSwitcher --------
" =============================

" -------- private --------

let s:executor = v:null
let s:index = 0
let s:mapTable = []

function! s:throwException(format, ...)
    throw call(function('printf'), extend(['MapSwitcher: ' . a:format], a:000))
endfunction

function! s:isReady()
    if s:executor == v:null
        call s:throwException('executor is not defined')
    endif

    if empty(s:mapTable)
        call s:throwException('map table is not defined')
    endif
endfunction

function! s:checkMapTable(value)
    " check presets
    for i in a:value
        " check name and map is defined in preset
        for testKey in ['name', 'mapping']
            if !has_key(i, testKey)
                call s:throwException("'%s' is not defined in the map table", testKey)
            endif
        endfor

        " check mapping of preset
        for [key, value] in items(i.mapping)
            " check isNore, isSilent, and rhs is defined in each key
            for testKey in ['isNore', 'isSilent', 'rhs']
                if !has_key(value, testKey)
                    call s:throwException("'%s' is not defined in key '%s' of '%s'", testKey, key, i.name)
                endif
            endfor
        endfor
    endfor
endfunction

function! s:map()
    let l:keys = []
    for i in s:mapTable
        for j in keys(i.mapping)
            if index(l:keys, j) == -1
                call add(l:keys, j)
            endif
        endfor
    endfor
    let l:keys = sort(l:keys)

    for i in l:keys
        let l:newRhs = ":call MapSwitcher_key('" . substitute(i, '<', '<lt>', 'g') . "')<CR>"

        " maparg(i, 'n') converts the <> notation and cause the map fails
        let l:mappedRhs = get(maparg(i, 'n', 0, 1), 'rhs', v:null)
        if empty(l:mappedRhs)
            execute 'nnoremap <unique> <silent>' i l:newRhs
        elseif l:mappedRhs !=# l:newRhs
            call s:throwException('cannot map to %s (%s)', i, l:mappedRhs)
        endif
    endfor
endfunction

" -------- public --------

function! g:MapSwitcher_newMapTable(...)
    let l:temp = []
    for i in a:000
        call add(l:temp, i)
    endfor
    return l:temp
endfunction

function! g:MapSwitcher_newPreset(name, ...)
    let l:temp = { 'name': a:name, 'mapping': {} }
    for i in a:000
        call extend(l:temp.mapping, i)
    endfor
    return l:temp
endfunction

function! g:MapSwitcher_newKey(key, isNore, isSilent, rhs)
    return { a:key: { 'isNore': a:isNore, 'isSilent': a:isSilent, 'rhs': a:rhs } }
endfunction

function! g:MapSwitcher_init(executor, mapTable)
    try
        call s:checkMapTable(a:mapTable)
    catch /.*/
        echoerr v:exception
        return
    endtry

    let s:executor = a:executor
    let s:mapTable = a:mapTable

    try
        call s:map()
    catch /.*/
        echoerr v:exception
        return
    endtry
endfunction

function! g:MapSwitcher_help()
    try
        call s:isReady()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:preset = s:mapTable[s:index]
    let l:length = max(map(keys(l:preset.mapping), 'strlen(v:val)'))

    echo '[' l:preset.name ']'
    for [key, value] in items(l:preset.mapping)
        echo printf('%*s: %s', l:length, key, value.rhs)
    endfor
endfunction

function! g:MapSwitcher_switch()
    try
        call s:isReady()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:length = len(s:mapTable)

    let s:index += 1
    if s:index >= l:length
        let s:index = 0
    endif

    echo printf('MapSwitcher(%d/%d): %s', s:index + 1, l:length, s:mapTable[s:index].name)
endfunction

function! g:MapSwitcher_key(key)
    try
        call s:isReady()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:function = get(s:mapTable[s:index].mapping, a:key, v:null)
    if !empty(l:function)
        let l:command = []
        call add(l:command, l:function.isNore ? 'nnoremap' : 'nmap')
        call add(l:command, '<buffer>')
        call add(l:command, l:function.isSilent ? '<silent>' : '')
        call add(l:command, s:executor)
        call add(l:command, l:function.rhs)
        execute join(l:command)

        let l:executor = '"' . escape(s:executor, '<') . '"'
        call feedkeys(eval(l:executor))
    endif
endfunction
