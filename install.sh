#!/usr/bin/env bash

# ========================
# -------- string --------
# ========================

readonly STRING_HELP_INFO="Try '$( basename "$0" ) -h' for more information."

readonly STRING_HELP=$( cat << EOF
Usage:
    $( basename "$0" ) (option...) [task]

Tasks:
    all              install bashrc and neovim, and check neovim's requirements
    bashrc           install bashrc only
    neovim-config    install neovim config only
    neovim-check     check neovim's requirements
    help             print help messages

Options:
    -h    print help messages
EOF
)

# ==========================
# -------- function --------
# ==========================

function getopts_printError()
{
    if [[ -n $2 ]]; then
        case $1 in
            :) echo "option requires an argument: -$2" ;;
            ?) echo "invalid option: -$2" ;;
            *) echo "unknown error" ;;
        esac
    fi
}

function confirmYesNo()
{
    local value
    while :; do
        read -ep "$1 (y/N): " value
        value=${value:-N}
        case $value in
            Y | y) true; return ;;
            N | n) false; return ;;
            *) echo "invalid input: $value" ;;
        esac
    done
}

function installBashConfig_linux()
{
    local -r INSTALL_PATH=$HOME/.bashrc
    local -r LINK_TARGET=$1/bash/bashrc

    echo "Linux environment detected. Installing .bashrc as a symlink."

    if [[ -L $INSTALL_PATH ]]; then
        local linkPath=$( readlink $INSTALL_PATH )
        if [[ $linkPath == $LINK_TARGET ]]; then
            echo ".bashrc is already installed."
            return
        fi
    fi

    if [[ -e $INSTALL_PATH || -L $INSTALL_PATH ]]; then
        echo ".bashrc already exists."
        confirmYesNo "Do you want to overwrite it?" || return
        echo -n "removing .bashrc..."
        rm $INSTALL_PATH
        echo " done"
    fi

    ln -s $LINK_TARGET $INSTALL_PATH
    echo ".bashrc installed: $INSTALL_PATH"
}

function installBashConfig_mingw()
{
    local -r INSTALL_PATH=$HOME/.bashrc
    local -r SOURCE_TARGET=$1/bash/bashrc
    local -r BASHRC_CONTENT="source $SOURCE_TARGET"

    echo "MINGW environment detected. Installing .bashrc as a source file."

    if [[ -e $INSTALL_PATH ]]; then
        local content=$( cat $INSTALL_PATH )
        if [[ $content == $BASHRC_CONTENT ]]; then
            echo ".bashrc is already installed."
            return
        fi
    fi

    if [[ -e $INSTALL_PATH || -L $INSTALL_PATH ]]; then
        echo ".bashrc already exists."
        confirmYesNo "Do you want to overwrite it?" || return
        echo -n "removing .bashrc..."
        rm $INSTALL_PATH
        echo " done"
    fi

    echo $BASHRC_CONTENT > $INSTALL_PATH
    echo ".bashrc installed: $INSTALL_PATH"
}

function installBashConfig()
{
    local -r SYSTEM_NAME=$( uname -s )
    case $SYSTEM_NAME in
        Linux) installBashConfig_linux "$@" ;;
        MINGW*) installBashConfig_mingw "$@" ;;
        *) echo "Unsupported system: $SYSTEM_NAME" ;;
    esac
}

function installNeovimConfig()
{
    local -r DIR=$HOME/.config/nvim
    local -r FILE=$DIR/init.lua
    if [[ ! -d $DIR ]]; then
        mkdir -p $DIR
    elif [[ -L $FILE ]]; then
        rm $FILE
        echo "old Neovim config removed"
    fi
    ln -s $1/neovim/init.lua $FILE
    echo "Neovim config installed: $FILE"
}

function checkNeovimPackage()
{
    local -Ar MAP=(
        [curl]=curl
        [gzip]=gzip
        [luarocks]=luarocks
        [node]=nodejs
        [npm]=npm
        [pip]=python3-pip
        [python3]=python3
        [tar]=tar
        [tree-sitter]="tree-sitter-cli (npm)"
        [unzip]=unzip
        [wget]=wget
    )

    echo "Checking Neovim requirements:"
    for key in ${!MAP[@]}; do
        local value=${MAP[$key]}

        echo -n "- $key command: "
        if command -v $key > /dev/null; then
            echo OK.
        else
            echo "Not found. Please install the '$value' package."
        fi
    done

    echo "For more information, please run the ':checkhealth' command in Neovim."
}

# ======================
# -------- main --------
# ======================

function main()
{
    local filename
    local flagVerbose=0

    OPTIND=1
    while getopts :f:vh opt; do
        case $opt in
            f) filename=$OPTARG ;;
            v) flagVerbose=1 ;;
            h)
                echo "$STRING_HELP"
                exit 0
                ;;
            *)
                getopts_printError "$opt" "$OPTARG"
                echo "$STRING_HELP_INFO"
                exit 1
                ;;
        esac
    done
    shift $(( OPTIND - 1 ))

    if (( ! $# )); then
        echo "requires a task"
        echo "$STRING_HELP_INFO"
        exit 1
    fi

    local -r SCRIPT_ROOT=$( dirname "$( realpath "${BASH_SOURCE[0]}" )" )

    local task=$1
    case $task in
        all)
            installBashConfig "$SCRIPT_ROOT"
            installNeovimConfig "$SCRIPT_ROOT"
            checkNeovimPackage
            exit 0
            ;;
        bashrc)
            installBashConfig "$SCRIPT_ROOT"
            exit 0
            ;;
        neovim-config)
            installNeovimConfig "$SCRIPT_ROOT"
            exit 0
            ;;
        neovim-check)
            checkNeovimPackage
            exit 0
            ;;
        help)
            echo "$STRING_HELP"
            exit 0
            ;;
        *)
            echo "invalid task: $task"
            echo "$STRING_HELP_INFO"
            exit 1
            ;;
    esac
}

main "$@"
