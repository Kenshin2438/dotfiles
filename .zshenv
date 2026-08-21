# Symlinked to $HOME/.zshenv by `just macos` / `just archlinux`.
# Redirects zsh to the XDG config dir, where the rest of the config lives.
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ -f "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
