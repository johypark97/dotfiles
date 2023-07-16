" =============================
" -------- MapSwitcher --------
" =============================

" -------- private --------

let s:executor = v:null
let s:index = 0
let s:isReady = v:false
let s:mapTable = []

function! s:throwException(format, ...)
    throw call(function('printf'), extend(['MapSwitcher: ' . a:format], a:000))
endfunction

function! s:isReady()
    if s:isReady == v:true
        return
    endif

    if s:executor == v:null
        call s:throwException('executor is not defined')
    endif

    if empty(s:mapTable)
        call s:throwException('mapTable is not defined')
    endif

    let s:isReady = v:true
endfunction

function! s:validMapTable(mapTable)
    " Check presets
    for preset in a:mapTable
        " Check if name and mapping keys exist in the preset dictionary
        for testKey in ['name', 'mapping']
            if !has_key(preset, testKey)
                call s:throwException("key '%s' is not defined in the preset", testKey)
            endif
        endfor

        " Check mapping values
        for [key, value] in items(preset.mapping)
            " Check if isNore, isSilent, and rhs keys exist in each key dictionary
            for testKey in ['isNore', 'isSilent', 'rhs']
                if !has_key(value, testKey)
                    call s:throwException("key '%s' is not defined in key '%s' of preset '%s'", testKey, key, preset.name)
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
        let l:newRhs = ":call g:mapSwitcher#key('" . substitute(i, '<', '<lt>', 'g') . "')<CR>"

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

function! g:mapSwitcher#newMapTable(...)
    let l:mapTable = []
    for i in a:000
        call add(l:mapTable, i)
    endfor
    return l:mapTable
endfunction

function! g:mapSwitcher#newPreset(name, ...)
    let l:preset = { 'name': a:name, 'mapping': {} }
    for i in a:000
        call extend(l:preset.mapping, i)
    endfor
    return l:preset
endfunction

function! g:mapSwitcher#newKey(key, isNore, isSilent, rhs)
    let l:key = {}
    let l:key[a:key] = { 'isNore': a:isNore, 'isSilent': a:isSilent, 'rhs': a:rhs }

    return l:key
endfunction

function! g:mapSwitcher#init(executor, mapTable)
    try
        call s:validMapTable(a:mapTable)
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

function! g:mapSwitcher#help()
    try
        call s:isReady()
    catch /.*/
        echoerr v:exception
        return
    endtry

    let l:preset = s:mapTable[s:index]
    let l:length = max(map(keys(l:preset.mapping), 'strlen(v:val)'))

    echo '<<' l:preset.name '>>'
    for [key, value] in items(l:preset.mapping)
        echo printf('%*s: %s', l:length, key, value.rhs)
    endfor
endfunction

function! g:mapSwitcher#switch()
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

function! g:mapSwitcher#key(key)
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
