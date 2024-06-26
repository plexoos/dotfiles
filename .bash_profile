if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dsmirnov/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dsmirnov/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dsmirnov/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dsmirnov/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/dsmirnov/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/dsmirnov/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

export PATH="${HOME}/.local/bin:$PATH"
