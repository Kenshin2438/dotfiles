My `dotfiles` for [Arch]Linux (Hyprland).

**_Important: use at your own risk. Test with dummy files before use it with your real dotfiles._**

---

## TODO

- [ ] Replace `waybar` with `ags` [Aylur's GTK Shell](https://aylur.github.io/ags-docs)

## Installation

### Dependency

[Reddit r/hyprland | What applications do you use for basic stuff? ](https://www.reddit.com/r/hyprland/comments/1bl735k/what_applications_do_you_use_for_basic_stuff/)

- Terminal: `alacritty`
- Shell: `fish`
- Window Manager: `hyprland`
  - Hypr Ecosystem(hypr\* projects): `hyprlock`, `hypridle`
- Theme:
  - GTK(3): `orchis-theme`
  - Icon: `adwaita-icon-theme`
  - Cursor: `bibata-cursor-theme`
  - Shell Prompt: `starship`
- Fonts:
  - basics(`noto-fonts-*`)
  - ZH-CN: `ttf-lxgw-wenkai`, `adobe-source-code-pro-fonts`
  - Nerd-Font: `ttf-firacode-nerd`, `otf-comicshanns-nerd`
- File Explorer: `nautilus [gnome]`
- Image Viewer: `loupe [gnome]`
- Music Player: `spotify-launcher`, `netease-cloud-music-gtk4`
- Editor: `neovim`, `code`, `obsidian`

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
