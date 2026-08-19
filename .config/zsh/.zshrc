# ZSH config
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# Initialize completion (dump file in XDG cache, not $ZDOTDIR)
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"
autoload -U compinit; compinit -d "$ZSH_CACHE_DIR/zcompdump"

# Plugins (managed as git submodules)
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# starship
eval "$(starship init zsh)"

# kitty
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# Local proxy (mihomo/clash)
# toggle_proxy --set 127.0.0.1:7890
# toggle_proxy --unset
toggle_proxy() {
  case "$1" in
    --set)
      export HTTP_PROXY="http://$2"
      export HTTPS_PROXY="http://$2"
      export ALL_PROXY="http://$2"
      export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com,::1,10.*.*.*"
      ;;
    --unset)
      unset HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY
      ;;
    *)
      echo "usage: toggle_proxy --set <host:port> | --unset" >&2
      return 1
      ;;
  esac
}
