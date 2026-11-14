#!/usr/bin/env bash

: # enable line-specific shellcheck suppression

# shellcheck disable=SC2155
readonly SCRIPT_ROOT=$( dirname "$( realpath "${BASH_SOURCE[0]}" )" )

# shellcheck disable=SC2155
readonly HELP_HINT="Try '$( basename "$0" ) -h' for more information."

# shellcheck disable=SC2155
readonly HELP_MAIN=$( cat << EOF
Usage:
    $( basename "$0" ) [OPTION]... COMMAND

Commands:
    all              install bashrc and neovim, and check neovim's requirements
    bashrc           install bashrc only
    neovim-config    install neovim config only
    neovim-check     check neovim's requirements
    help             display help information

Options:
    -h    display this help and exit
EOF
)

confirm_yes_no()
{
    local prompt=${1:?prompt is required}
    while :; do
        read -erp "$prompt (y/N): " value
        local value=${value:-N}
        case $value in
            Y | y) return 0 ;;
            N | n) return 1 ;;
            *) printf 'invalid input: %s\n' "$value" >&2 ;;
        esac
    done
}

is_symbolic_link_of()
{
    local -r LINK_PATH=${1:?link path is required}
    local -r TARGET_PATH=${2:?target path is required}

    [[ -L $LINK_PATH ]] || return 1

    local path
    path=$( readlink "$LINK_PATH" ) || {
        printf 'failed to read link path: %s\n' "$LINK_PATH" >&2
        return 1
    }

    [[ $path == "$TARGET_PATH" ]]
}

create_or_replace_symbolic_link()
{
    local -r LINK_PATH=${1:?link path is required}
    local -r TARGET_PATH=${2:?target path is required}

    if [[ -e $LINK_PATH || -L $LINK_PATH ]]; then
        printf 'removing old file... '
        rm "$LINK_PATH" || return 1
        printf 'done\n'
    fi

    printf 'creating new symbolic link... '

    local dir_path
    dir_path=$( dirname "$LINK_PATH" ) || return 1

    mkdir -p "$dir_path" || return 1
    ln -s "$TARGET_PATH" "$LINK_PATH" || return 1

    printf 'done\n'

}

install_bash_config()
{
    local -r LINK_PATH=$HOME/.bashrc
    local -r TARGET_PATH=$SCRIPT_ROOT/bash/bashrc

    printf 'Installing .bashrc\n'

    if is_symbolic_link_of "$LINK_PATH" "$TARGET_PATH"; then
        printf '.bashrc is already installed.\n'
        return 0
    fi

    if [[ -e $LINK_PATH || -L $LINK_PATH ]]; then
        printf '.bashrc is already exists: %s\n' "$LINK_PATH"
        confirm_yes_no "Do you want to overwrite it?" || return 0
    fi

    create_or_replace_symbolic_link "$LINK_PATH" "$TARGET_PATH" || return 0

    printf '.bashrc installed: %s\n' "$LINK_PATH"
}

install_neovim_config()
{
    local -r LINK_PATH=$HOME/.config/nvim/init.lua
    local -r TARGET_PATH=$SCRIPT_ROOT/neovim/init.lua

    printf 'Installing Neovim config\n'

    if is_symbolic_link_of "$LINK_PATH" "$TARGET_PATH"; then
        printf 'Neovim config is already installed.\n'
        return 0
    fi

    if [[ -e $LINK_PATH || -L $LINK_PATH ]]; then
        printf 'Neovim config is already exists: %s\n' "$LINK_PATH"
        confirm_yes_no "Do you want to overwrite it?" || return 0
    fi

    create_or_replace_symbolic_link "$LINK_PATH" "$TARGET_PATH" || return 0

    printf 'Neovim config installed: %s\n' "$LINK_PATH"
}

check_neovim_requirements()
{
    local -Ar MAP=(
        [curl]=curl
        [gzip]=gzip
        [node]=nodejs
        [npm]=npm
        [python3]=python3
        [tar]=tar
        [tree-sitter]="tree-sitter-cli (npm)"
        [unzip]=unzip
        [wget]=wget
    )

    local width=0

    local key
    for key in "${!MAP[@]}"; do
        local x=${#key}
        (( x > width )) && width=$x
    done
    (( width += 4 ))

    printf 'Checking Neovim requirements:\n'
    for key in "${!MAP[@]}"; do
        local value=${MAP[$key]}

        printf "%${width}s command: " "$key"
        if command -v "$key" > /dev/null; then
            printf 'OK.\n'
        else
            printf 'Not found. Please install the %s package.\n' "'$value'"
        fi
    done

    printf '%s\n' "For more information, please run the ':checkhealth' command in Neovim."
}

main()
{
    local OPTIND=1 OPTARG opt
    while getopts :h opt; do
        case $opt in
            h)
                printf '%s\n' "$HELP_MAIN"
                return 0
                ;;
            :)
                [[ -n $OPTARG ]] && \
                    printf 'option requires an argument: -%s\n' "$OPTARG" >&2
                printf '%s\n' "$HELP_HINT" >&2
                return 1
                ;;
            \?)
                [[ -n $OPTARG ]] && \
                    printf 'invalid option: -%s\n' "$OPTARG" >&2
                printf '%s\n' "$HELP_HINT" >&2
                return 1
                ;;
            *)
                printf 'unexpected error\n' >&2
                return 1
                ;;
        esac
    done
    shift $(( OPTIND - 1 ))

    (( $# )) || {
        printf 'command is required\n' >&2
        printf '%s\n' "$HELP_HINT" >&2
        return 1
    }

    local cmd=$1
    shift

    case $cmd in
        all)
            install_bash_config
            install_neovim_config
            check_neovim_requirements
            return 0
            ;;
        bashrc)
            install_bash_config
            return 0
            ;;
        neovim-config)
            install_neovim_config
            return 0
            ;;
        neovim-check)
            check_neovim_requirements
            return 0
            ;;
        help)
            printf '%s\n' "$HELP_MAIN"
            return 0
            ;;
        *)
            printf 'invalid command: %s\n' "$cmd" >&2
            printf '%s\n' "$HELP_HINT" >&2
            return 1
            ;;
    esac
}

main "$@"
