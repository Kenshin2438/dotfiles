set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive && ! status is-login
    starship init fish | source
end
