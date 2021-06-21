#!/bin/bash

scriptRoot=$( dirname "$( realpath "${BASH_SOURCE[0]}" )" )

function installBashConfig()
{
    local FILE=$HOME/.bashrc
    if [[ -f $FILE ]]; then
        rm $FILE
    fi
    ln -s $scriptRoot/bash/bashrc $FILE
}

function installNeovimConfig()
{
    local DIR=$HOME/.config/nvim
    local FILE=$DIR/init.vim
    if [[ ! -d $DIR ]]; then
        mkdir -p $DIR
    elif [[ -f $FILE ]]; then
        rm $FILE
    fi
    ln -s $scriptRoot/neovim/init.vim $FILE
}

function main()
{
    installBashConfig
    installNeovimConfig
}

main "$@"
