## My `dotfiles`

**_Important: use at your own risk. Test with dummy files before use it with your real dotfiles._**

---

### Enabling Configurations

Requires [just](https://github.com/casey/just). Each platform recipe creates
symlinks for the configs that apply to it; if a target path already exists,
`just` prints a warning and leaves it untouched instead of removing it.

```shell
cd $HOME
git clone git@github.com:Kenshin2438/dotfiles.git
cd dotfiles

just            # list available recipes
just macos      # macOS
just archlinux  # Arch Linux (full desktop, incl. the Hyprland stack)
just wsl        # WSL (CLI tools only)
just windows    # Windows (pwsh; symlinks need admin rights or Developer Mode)
```

On Arch Linux, regenerate themes after linking:

```shell
matugen image $HOME/wallpapers/{IMAGE}
```
