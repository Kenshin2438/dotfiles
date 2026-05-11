set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive && ! status is-login
    fish_config theme choose matugen
    starship init fish | source
end

if test "$TERM" = xterm-kitty
    alias ssh="kitty +kitten ssh"
end
