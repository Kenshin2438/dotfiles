# Cross-platform dotfiles bootstrap (macOS / Arch Linux / WSL / Windows).
#
#   just macos          link configs on macOS
#   just archlinux      link configs on Arch Linux (full desktop)
#   just wsl            link configs on WSL (CLI tools only)
#   just windows        link configs on Windows

dotfiles := justfile_directory()
home := home_directory()
config := home / ".config"

[private]
default:
  @just --list

# Link configs on macOS
[macos]
macos: \
  (link dotfiles/".config/nvim" config/"nvim") \
  (link dotfiles/".config/zed" config/"zed") \

# Link configs on Arch Linux (full desktop, incl. the Hyprland stack)
[linux]
archlinux: \
  (link dotfiles/"wallpapers"                     home/"wallpapers") \
  (link dotfiles/".agents"                        home/".agents") \
  (link dotfiles/".config/fontconfig"             config/"fontconfig") \
  (link dotfiles/".config/fuzzel"                 config/"fuzzel") \
  (link dotfiles/".config/hypr"                   config/"hypr") \
  (link dotfiles/".config/kitty"                  config/"kitty") \
  (link dotfiles/".config/matugen"                config/"matugen") \
  (link dotfiles/".config/nushell"                config/"nushell") \
  (link dotfiles/".config/nvim"                   config/"nvim") \
  (link dotfiles/".config/quickshell"             config/"quickshell") \
  (link dotfiles/".config/uwsm"                   config/"uwsm") \
  (link dotfiles/".config/zed"                    config/"zed") \
  (link dotfiles/".config/zsh"                    config/"zsh") \
  (link dotfiles/".config/electron-flags.conf"    config/"electron-flags.conf") \
  (link dotfiles/".config/qq-flags.conf"          config/"qq-flags.conf") \
  (link dotfiles/".config/spotify-launcher.conf"  config/"spotify-launcher.conf") \
  (link dotfiles/".config/starship.toml"          config/"starship.toml") \

# Link configs on WSL (CLI tools only)
[linux]
wsl:

# Link configs on Windows
[windows]
windows:

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
