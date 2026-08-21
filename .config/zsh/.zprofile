# Homebrew (macOS)
if [[ "$OSTYPE" == darwin* ]] && [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

## [Automatic] Start Hyprland (Linux only)
if (( $+commands[uwsm] )) && uwsm check may-start; then
    exec uwsm start hyprland-uwsm.desktop
fi
