" [neovim]
" https://neovim.io/
" https://github.com/neovim/neovim

" [init.vim]
" linux: ~/.config/nvim/init.vim
" windows: %LOCALAPPDATA%/nvim/init.vim
" echo $MYVIMRC
"   == &runtimepath . '/init.vim'
"   == stdpath('config') . '/init.vim'

" ========================
" -------- router --------
" ========================

let s:scriptRoot = fnamemodify(resolve(expand('<sfile>')), ':p:h')
execute 'set path+=' . s:scriptRoot

function! s:route(file)
    let l:path = findfile(a:file, s:scriptRoot)
    if empty(l:path)
        echoerr 'route() failed: cannot find' a:file
        return
    endif
    execute 'source' fnamemodify(l:path, ':p')
endfunction

" =======================
" -------- route --------
" =======================

if has('nvim-0.9')
    call s:route('0.9/init.vim')
else
    echoerr 'config does not support this version of neovim'
endif
