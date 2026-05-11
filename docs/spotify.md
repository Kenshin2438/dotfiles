## 0x0 Spotify

+ https://wiki.archlinux.org/title/Spotify
+ https://github.com/kpcyrd/spotify-launcher

```shell
yay -S spotify-launcher
```

---

## 0x1 Spicetify

https://spicetify.app/

```shell
yay -S aur/spicetify-cli

spicetify config # To create ~/.config/spicetify/config-xpui.ini
spicetify backup apply
```

### Theme

```shell
git clone --depth=1 https://github.com/catppuccin/spicetify.git
cp -r spicetify/catppuccin ~/.config/spicetify/Themes/
spicetify config current_theme catppuccin
spicetify config color_scheme frappe
```

### AD-Block

```shell
curl https://raw.githubusercontent.com/rxri/spicetify-extensions/main/adblock/adblock.js \
  > ~/.config/spicetify/Extensions/adblock.js
spicetify config extensions adblock.js
```
