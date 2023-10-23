Hi! This my personal dotfiles for Ricing Hyprland on ArchLinux.

---

## Installation

使用软链接将配置文件链接到 `$home` 目录下。

## Misc

加上一点简短~~有用~~的tutorial，以防在中文互联网迷路。

### 添加 `archlinuxcn` 源

如有变动，可参考TUNA的说明 [Arch Linux CN 软件仓库镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/archlinuxcn/) 。

```diff
$ sudo nvim /etc/pacman.conf
...
+ [archlinuxcn]
+ Server = https://mirrors.aliyun.com/archlinuxcn/$arch
```
添加后，安装 `archlinuxcn-keyring` 用以提供 GPG Key
```shell
sudo pacman -Sy archlinuxcn-keyring
```

### 配置 `git`

如有变动，可直接参考Github提供的SSH教程/帮助/手册。

```shell
git config --global user.email "xxxxx@xxxx.xxx"
git config --global user.name "Kenshin2438"
# ... zsh 补全很完整，猪脑袋也该看会了

ssh-keygen -t ed25519 -C "xxxxx@xxxx.xxx"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | wl-copy # 到设置里添加Key

ssh -T git@github.com
```
