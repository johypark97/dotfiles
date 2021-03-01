" ===============================
" -------- gruvbox-color --------
" ===============================

" -------- private --------

function! s:changeGruvboxColor(changeBackground, changeContrast)
    if g:colors_name != 'gruvbox'
        echo 'colorscheme is not gruvbox'
        return
    endif

    if a:changeBackground
        if &background == 'dark'
            set background=light
        else
            set background=dark
        endif
    endif

    let l:contrast = 'g:gruvbox_contrast_' . &background
    if a:changeContrast
        let l:lookup = { 'hard': 'medium', 'medium': 'soft', 'soft': 'hard' }
        let {l:contrast} = l:lookup[{l:contrast}]
        colorscheme gruvbox
    endif

    echo 'colorscheme: gruvbox -' {l:contrast} &background
endfunction

" -------- public --------

function! g:Init_changeGruvboxBackground()
    call s:changeGruvboxColor(1, 0)
endfunction

function! g:Init_changeGruvboxContrast()
    call s:changeGruvboxColor(0, 1)
endfunction

function! g:Init_cycleGruvboxColor()
    let l:contrast = {'g:gruvbox_contrast_' . &background}
    call s:changeGruvboxColor(l:contrast == 'soft', 1)
endfunction
