set -g fish_greeting
set -gx EDITOR nvim

if status is-login
    if test (tty) = /dev/tty1
        exec Hyprland &>/dev/null
    end
end

if status is-interactive && ! status is-login
    starship init fish | source
end