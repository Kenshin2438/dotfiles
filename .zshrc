## zsh  == login shell && fish == interactive shell
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && $SHLVL == 1 ]]; then
    if [[ -o login ]]; then
        LOGIN_OPTION='--login'
    else
        LOGIN_OPTION=''
    fi
    exec fish $LOGIN_OPTION
fi
