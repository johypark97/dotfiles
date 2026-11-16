#!/usr/bin/env bash

# shell option
HISTCONTROL=ignoreboth
HISTFILESIZE=4096
HISTSIZE=1024

shopt -s checkwinsize
shopt -s histappend

# path
if [[ $OSTYPE == linux-gnu ]]; then
    if [[ -d $HOME/.cargo/bin ]]; then
        _dotfiles_prepend_path "$HOME/.cargo/bin"
    fi

    if command -v npm > /dev/null; then
        _dotfiles_prepend_path "$( npm config get prefix )/bin"
    fi
fi

# umask
umask 0007
_dotfiles_prompt_set_default_umask 0007

# prompt
if (( $( tput colors 2>/dev/null ) >= 8 )); then
    _dotfiles_prompt_set_terminal_color 1
fi

if [[ $( locale charmap 2>/dev/null ) == UTF-8 ]]; then
    _dotfiles_prompt_set_terminal_unicode 1
fi

_dotfiles_prompt_setup
