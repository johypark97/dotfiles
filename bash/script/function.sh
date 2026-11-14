#!/usr/bin/env bash

_dotfiles_append_path() {
    [[ -n ${1-} ]] || return 1
    [[ :$PATH: == *:"$1":* ]] || export PATH=${PATH:+$PATH:}$1
}

_dotfiles_prepend_path() {
    [[ -n ${1-} ]] || return 1
    [[ :$PATH: == *:"$1":* ]] || export PATH=$1${PATH:+:$PATH}
}
