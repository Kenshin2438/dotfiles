My `dotfiles` for [Arch]Linux (Hyprland).

**_Important: use at your own risk. Test with dummy files before use it with your real dotfiles._**

---

## Installation

### Dependency

[Reddit r/hyprland | What applications do you use for basic stuff? ](https://www.reddit.com/r/hyprland/comments/1bl735k/what_applications_do_you_use_for_basic_stuff/)

- Terminal: `alacritty`
- Shell: `fish`
- Window Manager: `hyprland`
  - Hypr Ecosystem(hypr\* projects): `hyprlock`, `hypridle`
  - Plugins: `hyprexpo`
- Theme:
  - QT: [Kvantum catppuccin-frappe](https://github.com/catppuccin/Kvantum)
  - GTK(3): `orchis-theme`
  - Icon: `papirus-icon-theme`
  - Cursor: `bibata-cursor-theme`
  - Shell Prompt: `starship`
- Fonts:
  - basics(`noto-fonts-*`)
  - ZH-CN: `ttf-lxgw-wenkai`, `adobe-source-code-pro-fonts`
  - Symbols/Mono/Nerd Font: `ttf-firacode-nerd`, `otf-comicshanns-nerd`, `ttf-jetbrains-mono`, `ttf-ibm-plex`
- File Explorer: `nautilus [gnome]`
- Document Viewer: `evince [gnome]`
- Image Viewer: `loupe [gnome]`
- Music Player: `spotify-launcher`
- Editor: `neovide(neovim)`, `code`, `obsidian`, `zed`

### Enabling Configurations

**Create symbolic links** and **resolve conflicts** _manually_.

```shell
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
...
```

### Misc. Login Prompt

- https://wiki.archlinux.org/title/ASCII_art
- https://wiki.archlinux.org/title/Arch_boot_process#Login

```shell
sudo cp ~/dotfiles/login/issue /etc/issue
```

### Misc. Better `pacman/yay`

```diff
# File: /etc/pacman.conf
========================
# Misc options
+ Color
+ VerbosePkgLists
+ ParallelDownloads = 5
```

### Misc. Spotify

```shell
yay -S spotify-launcher spicetify-cli

spicetify config # To create ~/.config/spicetify/config-xpui.ini
spicetify backup apply

cd /tmp
git clone --depth=1 https://github.com/catppuccin/spicetify.git
cd spicetify/
cp -r catppuccin ~/.config/spicetify/Themes/
spicetify config current_theme catppuccin
spicetify config color_scheme frappe

curl https://raw.githubusercontent.com/rxri/spicetify-extensions/main/adblock/adblock.js \
  > ~/.config/spicetify/Extensions/adblock.js
spicetify config extensions adblock.js

spicetify apply
```
