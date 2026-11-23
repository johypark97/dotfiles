#!/usr/bin/env bash

: # for line-specific ShellCheck suppression

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
        read -erp "$prompt (y/N): " value || return 1
        local value=${value:-N}
        case $value in
            Y | y) return 0 ;;
            N | n) return 1 ;;
            *) printf 'invalid input: %s\n' "$value" >&2 ;;
        esac
    done
}

dpkg_is_installed() {
    [[ -n ${1-} ]] || return 1
    local status
    status=$( dpkg-query -W -f='${Status}' "$1" 2>/dev/null ) || return 1
    [[ $status == "install ok installed" ]]
}

trim() {
    local x=${1?argument is required}
    x=${x#"${x%%[![:space:]]*}"}
    x=${x%"${x##*[![:space:]]}"}
    printf '%s' "$x"
}

is_symbolic_link_of()
{
    local link_path=${1:?link path is required}
    local target_path=${2:?target path is required}

    [[ -L $link_path ]] || return 1

    local path
    path=$( readlink "$link_path" ) || {
        printf 'failed to read link path: %s\n' "$link_path" >&2
        return 1
    }

    [[ $path == "$target_path" ]]
}

create_or_replace_symbolic_link()
{
    local link_path=${1:?link path is required}
    local target_path=${2:?target path is required}

    if [[ -e $link_path || -L $link_path ]]; then
        printf 'removing old file... '
        rm "$link_path" || return 1
        printf 'done\n'
    fi

    printf 'creating new symbolic link... '

    local dir_path
    dir_path=$( dirname "$link_path" ) || return 1

    mkdir -p "$dir_path" || return 1
    ln -s "$target_path" "$link_path" || return 1

    printf 'done\n'

}

install_bash_config()
{
    local link_path=$HOME/.bashrc
    local target_path=$SCRIPT_ROOT/bash/bashrc

    printf 'Installing .bashrc\n'

    if is_symbolic_link_of "$link_path" "$target_path"; then
        printf '.bashrc is already installed.\n'
        return 0
    fi

    if [[ -e $link_path || -L $link_path ]]; then
        printf '.bashrc is already exists: %s\n' "$link_path"
        confirm_yes_no "Do you want to overwrite it?" || return 0
    fi

    create_or_replace_symbolic_link "$link_path" "$target_path" || return 0

    printf '.bashrc installed: %s\n' "$link_path"
}

install_neovim_config()
{
    local link_path=$HOME/.config/nvim/init.lua
    local target_path=$SCRIPT_ROOT/neovim/init.lua

    printf 'Installing Neovim config\n'

    if is_symbolic_link_of "$link_path" "$target_path"; then
        printf 'Neovim config is already installed.\n'
        return 0
    fi

    if [[ -e $link_path || -L $link_path ]]; then
        printf 'Neovim config is already exists: %s\n' "$link_path"
        confirm_yes_no "Do you want to overwrite it?" || return 0
    fi

    create_or_replace_symbolic_link "$link_path" "$target_path" || return 0

    printf 'Neovim config installed: %s\n' "$link_path"
}

is_requirement_installed()
{
    local target_field_width=${1:?target field width is required}
    local requirement_line=${2:?requirement line is required}

    local -a fields
    IFS=, read -ra fields <<< "$requirement_line"

    (( ${#fields[@]} == 3 )) || {
        printf 'invalid format: requirement line\n' >&2
        return 1
    }

    local i
    for i in "${!fields[@]}"; do
        fields[i]=$( trim "${fields[i]}" )
    done

    local type=${fields[0]}
    local target=${fields[1]}
    local install=${fields[2]}

    printf "%${target_field_width}s %s: " "$target" "$type"
    case "$type" in
        command)
            if command -v "$target" > /dev/null; then
                printf 'OK.\n'
            else
                printf 'Not found. %s\n' "$install"
            fi
            ;;
        package)
            if dpkg_is_installed "$target"; then
                printf 'OK.\n'
            else
                printf 'Not installed. %s\n' "$install"
            fi
            ;;
    esac
}

check_neovim_requirements()
{
    local -r TARGET_FIELD_WIDTH=16

    local -ra REQUIRED=(
        # type    target       install
        "command, git,         Please install the 'git' package using apt."

        "command, curl,        Please install the 'curl' package using apt."
        "command, wget,        Please install the 'wget' package using apt."

        "command, tar,         Please install the 'tar' package using apt."
        "command, gzip,        Please install the 'gzip' package using apt."
        "command, unzip,       Please install the 'unzip' package using apt."

        "command, python3,     Please install the 'python3' package using apt."

        "command, node,        Please install the 'nodejs' package using apt."
        "command, npm,         Please install the 'npm' package using apt."
        "command, tree-sitter, Please install the 'tree-sitter-cli' package using npm."
    )

    local -ra OPTIONAL=(
        # type    target         install
        "command, clangd,        Please install the 'clangd' package using apt."
        "command, clang-format,  Please install the 'clang-format' package using apt."

        "command, cargo,         Please install 'rust' form https://rust-lang.org/"
        "command, rust-analyzer, Please install 'rust-analyzer' using the command 'rustup component add rust-analyzer'."

        "command, pip,           Please install the 'python3-pip' package using apt."
        "package, python3-venv,  Please install the 'python3-venv' package using apt."
    )

    local line

    printf 'Checking Neovim requirements:\n'
    for line in "${REQUIRED[@]}"; do
        is_requirement_installed "$TARGET_FIELD_WIDTH" "$line" || return 1
    done
    printf 'Checking optional requirements:\n'
    for line in "${OPTIONAL[@]}"; do
        is_requirement_installed "$TARGET_FIELD_WIDTH" "$line" || return 1
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
