#!/usr/bin/env bash

declare -gA _dotfiles_prompt_var=(
    [default_umask]=000
    [git_prefix]=""
    [git_separator]=""
    [git_suffix]=""
    [info_prefix]=""
    [info_separator]=""
    [info_suffix]=""
    [terminal_color]=0
    [terminal_unicode]=0
)

_dotfiles_prompt_set_default_umask()
{
    local value=$1
    [[ $value =~ ^[0-7]{1,4}$ ]] || return 1
    value=000$value
    _dotfiles_prompt_var[default_umask]=${value: -4}
}

_dotfiles_prompt_set_terminal_color()
{
    _dotfiles_prompt_var[terminal_color]=$1
}

_dotfiles_prompt_set_terminal_unicode()
{
    _dotfiles_prompt_var[terminal_unicode]=$1
}

# https://stackoverflow.com/a/5032641
_dotfiles_strindex()
{
    local x=${1%%"$2"*}
    [[ $x == "$1" ]] && printf '%d' -1 || printf '%d' "${#x}"
}

# https://www.gnu.org/software/bash/manual/bash.html#Controlling-the-Prompt
# https://en.wikipedia.org/wiki/ANSI_escape_code
# "\[" == "\001", "\]" == "\002", "\e" == "\033"
_dotfiles_wrap_sgr()
{
    local IFS=\;
    printf '\001\033[%sm\002' "$*"
}

_dotfiles_parse_tag()
{
    local string=$1
    local callback=$2
    local tag_open=${3:-<<}
    local tag_close=${4:->>}

    local i=0
    while :; do
        local tag_begin
        tag_begin=$( _dotfiles_strindex "${string:$i}" "$tag_open" )
        (( tag_begin == -1 )) && break
        (( tag_begin += i ))

        local content_begin=$(( tag_begin + ${#tag_open} ))
        local content_length
        content_length=$( _dotfiles_strindex "${string:$content_begin}" "$tag_close" )
        (( content_length == -1 )) && break

        local tag_length=$(( ${#tag_open} + content_length + ${#tag_close} ))

        printf '%s' "${string:$i:$(( tag_begin - i ))}"
        if [[ -n $callback ]]; then
            local content=${string:$content_begin:$content_length}
            printf '%s' "$( "$callback" "$content" )"
        fi

        (( i = tag_begin + tag_length ))
    done

    printf '%s' "${string:$i}"
}

_dotfiles_parse_tag_callback()
{
    local type=${1::1}
    local value=${1:1}

    case $type in
        c)
            (( _dotfiles_prompt_var[terminal_color] )) && \
                printf '%s' "$( _dotfiles_wrap_sgr "$value" )"
            ;;
        u)
            local delimiter=${value::1}
            value=${value:1}
            if (( _dotfiles_prompt_var[terminal_unicode] )); then
                printf '%b' "${value%%"$delimiter"*}"
            elif [[ $value == *"$delimiter"* ]]; then
                printf '%s' "${value#*"$delimiter"}"
            fi
            ;;
        \\) printf '%b' "\\$value" ;;
        *) printf '[ERROR]' ;;
    esac
}

_dotfiles_prompt_command_info()
{
    local -a array

    # newgrp info
    (( $( id -u ) != $( id -g ) )) && array+=( "$( id -gn )" )

    # umask info
    local current_umask
    current_umask=$( umask )
    (( current_umask != _dotfiles_prompt_var[default_umask] )) && \
        array+=( "$current_umask(${_dotfiles_prompt_var[default_umask]})" )

    # print
    (( ${#array} )) || return 1

    printf '%s%s' "${_dotfiles_prompt_var[info_prefix]}" "${array[0]}"
    local i
    for i in "${array[@]:1}"; do
        printf '%s%s' "${_dotfiles_prompt_var[info_separator]}" "$i"
    done
    printf '%s' "${_dotfiles_prompt_var[info_suffix]}"
}

_dotfiles_prompt_command_git()
{
    local git_root
    git_root=$( git rev-parse --show-toplevel 2>/dev/null ) || return 1
    git_root=$( basename "$git_root" )

    local git_branch
    git_branch=$( git rev-parse --abbrev-ref HEAD 2>/dev/null ) || return 1

    printf '%s%s%s%s%s' \
        "${_dotfiles_prompt_var[git_prefix]}" \
        "$git_root" \
        "${_dotfiles_prompt_var[git_separator]}" \
        "$git_branch" \
        "${_dotfiles_prompt_var[git_suffix]}"
}

_dotfiles_prompt_command()
{
    local x=0
    _dotfiles_prompt_command_info && x=1
    _dotfiles_prompt_command_git && x=1
    (( x )) && printf '\n'
}

_dotfiles_prompt_setup()
{
    PROMPT_COMMAND=_dotfiles_prompt_command
    PS1=$( _dotfiles_parse_tag "<<c1;32>>[\u@\h]<<c0>>:<<c1;34>>\w<<c0>>\\$ " _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[git_prefix]=$( _dotfiles_parse_tag "<<c1;31>><<u/\u27EA /{>>" _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[git_separator]=$( _dotfiles_parse_tag "<<u/ \u00BB //>>" _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[git_suffix]=$( _dotfiles_parse_tag "<<u/ \u27EB/}>><<c0>>" _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[info_prefix]=$( _dotfiles_parse_tag "<<c1;33>><<u/\u27E8 /[>>" _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[info_separator]=$( _dotfiles_parse_tag "<<u/ \u2022 /:>>" _dotfiles_parse_tag_callback )
    _dotfiles_prompt_var[info_suffix]=$( _dotfiles_parse_tag "<<u/ \u27E9/]>><<c0>>" _dotfiles_parse_tag_callback )
}
