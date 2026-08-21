## XDG Base Configuration

zsh is redirected to `$XDG_CONFIG_HOME/zsh` via a bootstrap `$HOME/.zshenv`,
which lives at the repo root (`.zshenv`) and is symlinked into place by
`just macos` / `just archlinux`:

```zsh
# $HOME/.zshenv
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ -f "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
```

Everything else (`.zshrc`, `.zprofile`, plugins) lives in `.config/zsh/`.
Platform-specific bits are guarded by `$OSTYPE` (`darwin*` / `linux*`);
the Hyprland auto-start in `.zprofile` only runs when `uwsm` is available.
