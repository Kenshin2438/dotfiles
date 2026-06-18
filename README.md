## My `dotfiles`

**_Important: use at your own risk. Test with dummy files before use it with your real dotfiles._**

---

### Enabling Configurations (Linux or MacOS)

```
cd $HOME
git clone git@github.com:Kenshin2438/dotfiles.git
cd dotfiles
stow .
matugen image $HOME/wallpapers/{IMAGE}
```

### Enabling Configurations (Windows)

```powershell
cd $HOME
git clone git@github.com:Kenshin2438/dotfiles.git
cd dotfiles

New-Item -ItemType SymbolicLink $HOME\.config\starship.toml -Target "$HOME\dotfiles\.config\starship.toml"
New-Item -ItemType SymbolicLink $PROFILE -Target "$HOME\dotfiles\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
. $PROFILE # refresh powershell config

New-Item -ItemType SymbolicLink $HOME\.config\mihomo   -Target "$HOME\dotfiles\.config\mihomo"
New-Item -ItemType SymbolicLink $HOME\.config\opencode -Target "$HOME\dotfiles\.config\opencode"
New-Item -ItemType SymbolicLink $HOME\.config\wezterm  -Target "$HOME\dotfiles\.config\wezterm"
New-Item -ItemType SymbolicLink $env:LOCALAPPDATA\nvim -Target "$HOME\dotfiles\AppData\Local\nvim"
New-Item -ItemType SymbolicLink $env:APPDATA\alacritty -Target "$HOME\dotfiles\AppData\Roaming\alacritty"
New-Item -ItemType SymbolicLink $env:APPDATA\VSCodium  -Target "$HOME\dotfiles\AppData\Roaming\VSCodium"
```
