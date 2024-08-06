set -g fish_greeting
set -gx EDITOR nvim

if status is-login # Auto start Hyprland on tty1
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec dbus-run-session Hyprland &>/dev/null
    end
end

if status is-interactive && ! status is-login
    starship init fish | source
end
