#!/usr/bin/env bash

# Command line
PS1="[\e[1;35m\u@\H:\e[m\e[0;34m\w\e[m] \n$ "

# Do not echo ^C back to terminal
stty -ctlecho

export LS_COLORS='di=01;94:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:ow=0'
export EDITOR=vim
export VISUAL=vim

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists gls ; then
   MYCMD_LS='gls --color=auto'
else
   MYCMD_LS='ls --color=auto'
fi

alias ls="$MYCMD_LS"
alias ll="$MYCMD_LS -lh"
alias la="$MYCMD_LS -lah"
alias hgrep="history | grep"
alias mytig="tig --all"
alias vimdiff="vimdiff -o"

function duf {
    du -h "$@" | sort -rn | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

mkcdir() { mkdir -p -- "$1" && cd -P -- "$1"; }

# First argument is a wildcard to match file names, defaults to "*.orig"
# Second argument is a path to traverse, defaults to current dir "./"
rmrec()
{
    file_pattern=${1:-*.orig}
    file_list=( $(find "${2:-.}" -name "${file_pattern}") )

    if [ ${#file_list[@]} -eq 0 ]
    then
        echo "No \"${file_pattern}\" files found"
    else
        echo "Files to delete in ${2:-./}:"
        printf '%s\n' "${file_list[@]}"
        confirm && rm "${file_list[@]}"
    fi
}

# Call with a prompt string or use a default
confirm()
{
    read -r -p "${1:-Are you sure? [y/n]} " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        true
    else
        false
    fi
}


declare -x LANG="en_US.UTF-8"
shopt -s direxpand

