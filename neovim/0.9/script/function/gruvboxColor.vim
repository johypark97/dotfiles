" ==============================
" -------- GruvboxColor --------
" ==============================

" -------- private --------

let s:BACKGROUND_LOOKUP = { 'dark': 'light', 'light': 'dark' }
let s:CONTRAST_LOOKUP = { 'hard': 'medium', 'medium': 'soft', 'soft': 'hard' }

function! s:changeColor(changeBackground, changeContrast)
    if g:colors_name != 'gruvbox'
        echoerr 'colorscheme is not gruvbox'
        return
    endif

    if a:changeBackground
        execute 'set background=' . s:BACKGROUND_LOOKUP[&background]
    endif

    let l:contrastVariable = 'g:gruvbox_contrast_' . &background
    if a:changeContrast
        let {l:contrastVariable} = s:CONTRAST_LOOKUP[{l:contrastVariable}]
        colorscheme gruvbox
    endif

    echo 'colorscheme: gruvbox -' {l:contrastVariable} &background
endfunction

" -------- public --------

function! g:gruvboxColor#changeBackground()
    call s:changeColor(1, 0)
endfunction

function! g:gruvboxColor#changeContrast()
    call s:changeColor(0, 1)
endfunction

function! g:gruvboxColor#cycleColor()
    let l:contrast = {'g:gruvbox_contrast_' . &background}
    call s:changeColor(l:contrast == 'soft', 1)
endfunction
