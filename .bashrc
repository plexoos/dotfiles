#!/usr/bin/env bash

# Command line
PS1="[\u@\H:\w]\n$"

#bind "^[[3~" delete-char

# Do not echo ^C back to terminal
stty -ctlecho

export LS_COLORS='di=01;94:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export EDITOR=vim
export PATH=~/usr/local/bin:~/bin:$PATH:./

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists gls ; then
   export MYCMD_LS='gls --color'
else
   export MYCMD_LS='ls --color'
fi

alias ls="$MYCMD_LS"
alias lh="$MYCMD_LS -lh"
alias la="$MYCMD_LS -lah"
alias hgrep="history | grep"
alias mygitk="gitk --all&"
alias abs="find `pwd` -samefile"
alias mycondor_q="condor_q smirnovd"

function duf {
   du -h "$@" | sort -rn | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

set autolist
#set filesc
#set nobeep
declare -x LANG="en_US"
