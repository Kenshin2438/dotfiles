## Universal Wayland Session Manager (`uwsm`)

### Auto start `Hyprland` after login

+ [zprofile](../.config/zsh/.zprofile)

```shell
chsh -s /bin/zsh # login shell
ln -sf $REPO_ROOT/.config/zsh/.zprofile ~/.zprofile
```

### Hypr-Ecosystem Applications *Run at startup*

```shell
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hypridle.service
systemctl --user enable --now hyprpolkitagent.service
```

---

## Monitor/Display Settings

```shell
yay -S nwg-displays
```
