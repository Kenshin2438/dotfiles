set -g fish_greeting
set -gx EDITOR nvim

if status is-login # Auto start Hyprland on tty1
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        mkdir -p ~/.cache
        exec Hyprland > ~/.cache/hyprland.log 2>&1
    end
end

if status is-interactive && ! status is-login
    starship init fish | source
end
