#!/usr/bin/env bash

# Command line
PS1="[\u@\H:\w]\n$"

#bind "^[[3~" delete-char

# Do not echo ^C back to terminal
stty -ctlecho

export LS_COLORS='di=01;94:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export EDITOR=vim
export VISUAL=vim
export PATH=.:~/usr/local/bin:$PATH

# Non-default paths for my local compilers used by cmake
export CC=/afs/rhic.bnl.gov/rcassoft/x8664_sl6/gcc482/bin/gcc
export CXX=/afs/rhic.bnl.gov/rcassoft/x8664_sl6/gcc482/bin/g++
export LD_LIBRARY_PATH+=":/afs/rhic.bnl.gov/rcassoft/x8664_sl6/gcc482/lib"

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists gls ; then
   export MYCMD_LS='gls --color=auto'
else
   export MYCMD_LS='ls --color=auto'
fi

alias ls="$MYCMD_LS"
alias lh="$MYCMD_LS -lh"
alias la="$MYCMD_LS -lah"
alias hgrep="history | grep"
alias mygitk="gitk --all&"
alias mycondor_q="condor_q smirnovd"
alias vimdiff="vimdiff -o"

function duf {
   du -h "$@" | sort -rn | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

mkcdir() { mkdir -p -- "$1" && cd -P -- "$1"; }


# Takes a path as first argument or defaults to current dir "./"
rmorig()
{
    file_list=(`find "${1:-./}" -name "*.orig"`)

    if [ ${#file_list[@]} -eq 0 ]
    then
        echo "No \"*.orig\" files found"
    else
        echo "Files to delete in ${1:-./}:"
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


set autolist
#set filesc
#set nobeep
declare -x LANG="en_US"
