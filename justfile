# Cross-platform dotfiles bootstrap (macOS / Arch Linux / WSL / Windows).
#
#   just macos          link configs on macOS
#   just archlinux      link configs on Arch Linux (full desktop)
#   just wsl            link configs on WSL (CLI tools only)
#   just windows        link configs on Windows

dotfiles := justfile_directory()
home := home_directory()
config := home / ".config"

# Link configs on macOS
[macos]
macos: \
    (link dotfiles/".config/nvim" config/"nvim") \
    (link dotfiles/".config/zed" config/"zed")

# Link configs on Arch Linux (full desktop, incl. the Hyprland stack)
[linux]
archlinux: \
    (link dotfiles/".config/nvim" config/"nvim") \

# Link configs on WSL (CLI tools only)
[linux]
wsl: \
    (link dotfiles/".config/fish" config/"fish") \
    (link dotfiles/".config/nvim" config/"nvim") \
    (link dotfiles/".config/opencode" config/"opencode") \
    (link dotfiles/".config/starship.toml" config/"starship.toml")

# Link configs on Windows
[windows]
windows: \
    (link dotfiles/".config/starship.toml" home/".config/starship.toml") \
    (link dotfiles/".config/mihomo" home/".config/mihomo") \
    (link dotfiles/".config/opencode" home/".config/opencode") \
    (link dotfiles/".config/wezterm" home/".config/wezterm") \
    (link dotfiles/".config/nvim" env('LOCALAPPDATA')/"nvim") \
    (link dotfiles/".config/zed" env('APPDATA')/"Zed") \
    (link dotfiles/"Documents/PowerShell/Microsoft.PowerShell_profile.ps1" home/"Documents/PowerShell/Microsoft.PowerShell_profile.ps1") \
    (link dotfiles/"AppData/Roaming/nushell" env('APPDATA')/"nushell")

# Symlink SRC to DST; if DST exists, warn instead of removing it
[private, unix]
link src dst:
    #!/usr/bin/env bash
    set -euo pipefail
    src="{{src}}"
    dst="{{dst}}"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      echo "ok      $dst"
    elif [ -e "$dst" ] || [ -L "$dst" ]; then
      echo "warning $dst already exists; remove it manually to re-link" >&2
    else
      mkdir -p "$(dirname "$dst")"
      ln -s "$src" "$dst"
      echo "link    $dst -> $src"
    fi

# Symlink SRC to DST; if DST exists, warn instead of removing it
[private, windows]
[extension('.ps1')]
[script("pwsh", "-NoProfile", "-File")]
link src dst:
    $ErrorActionPreference = "Stop"
    $src = "{{src}}"
    $dst = "{{dst}}"
    $item = Get-Item $dst -ErrorAction SilentlyContinue
    if ($null -ne $item -and $item.LinkType -and $item.Target -eq $src) {
      Write-Output "ok      $dst"
    } elseif (Test-Path $dst) {
      Write-Warning "$dst already exists; remove it manually to re-link"
    } else {
      New-Item -ItemType Directory -Force -Path (Split-Path $dst) | Out-Null
      New-Item -ItemType SymbolicLink -Path $dst -Target $src | Out-Null
      Write-Output "link    $dst -> $src"
    }
