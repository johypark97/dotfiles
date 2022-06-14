" [neovim]
" https://neovim.io/
" https://github.com/neovim/neovim

" [init.vim]
" linux: ~/.config/nvim/init.vim
" windows: %LOCALAPPDATA%/nvim/init.vim
" echo $MYVIMRC
"   == &runtimepath . '/init.vim'
"   == stdpath('config') . '/init.vim'

" [vim-plug]
" https://github.com/junegunn/vim-plug

" =================================================
" -------- vim-plug automatic installation --------
" =================================================

function! s:installVimPlug()
    let l:path = stdpath('data') . '/site/autoload/plug.vim'
    let l:url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if empty(glob(l:path))
        execute '!curl -fLo' l:path '--create-dirs' l:url
        if has('nvim-0.4')
            autocmd VimEnter * ++once PlugInstall --sync | source $MYVIMRC
        else
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    endif
endfunction

call s:installVimPlug()

" ===============================
" -------- source script --------
" ===============================

let s:scriptRoot = fnamemodify(resolve(expand('<sfile>')), ':p:h')
execute 'set path+=' . s:scriptRoot

function! g:Init_sourceScript(file)
    let l:path = findfile(a:file, s:scriptRoot)
    if empty(l:path)
        echoerr 'Init_sourceScript() failed: cannot find' a:file
        return
    endif
    execute 'source' fnamemodify(l:path, ':p')
endfunction

call g:Init_sourceScript('script/function.vim')
call g:Init_sourceScript('script/plugin.vim')
call g:Init_sourceScript('script/mapping.vim')
call g:Init_sourceScript('script/config.vim')
call g:Init_sourceScript('script/command.vim')
