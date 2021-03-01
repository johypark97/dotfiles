" =========================
" -------- utility --------
" =========================

function! g:Init_callAleFixFormat()
    if !exists('g:ale_fixers')
        echoerr 'g:ale_fixers is not defined'
        return
    endif

    if !exists('g:init_aleFormaters')
        echoerr 'g:init_aleFormaters is not defined'
        return
    endif

    let b:ale_fixers = extend(copy(g:ale_fixers), g:init_aleFormaters)
    ALEFix
    unlet b:ale_fixers
endfunction

function! g:Init_normalizeCompileCommands()
    if !exists('g:cmake_build_dir')
        echoerr 'g:cmake_build_dir is not defined'
        return
    endif

    let l:path = finddir(g:cmake_build_dir, getcwd() . ';')
    if l:path ==# ''
        echoerr 'cannot find CMake build directory'
        return
    endif

    let l:path = findfile('compile_commands.json', l:path)
    if l:path ==# ''
        echoerr 'cannot find compile_commands.json file'
        return
    endif

    if !executable('sed')
        echoerr 'sed is not executable'
        return
    endif

    let l:regex = "'" . 's;\\\\;/;g' . "'"
    execute '!sed --posix -i' escape(l:regex, '\') l:path

    " tabnew
    " execute 'arglocal' l:path
    " silent! argdo %s;\\\\;/;g
    " update
    " argdo bwipeout
endfunction

function! g:Init_getVimspectorSchemaPath(file)
    let l:path = findfile('vimspector/docs/schema/' . a:file, g:init_vimPlugHome)
    if l:path ==# ''
        echoerr 'cannot find' a:file
        return
    endif

    let l:path = substitute(l:path, '\\', '/', 'g')
    if has('win32')
        let l:path = '/' . l:path
    endif

    return 'file://' . l:path
endfunction
