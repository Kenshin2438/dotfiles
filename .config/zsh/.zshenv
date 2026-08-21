# spiectify-cli
export PATH="$HOME/.spicetify:$PATH"
# kimi-code
export PATH="$HOME/.kimi-code/bin:$PATH"
# huawei-deveco
export PATH="$HOME/Huawei/command-line-tools/bin:$PATH"
export PATH="$HOME/Huawei/command-line-tools/sdk/default/openharmony/toolchains:$PATH"
# SDK for arkts LSP
export HARMONYOS_SDK_PATH="$HOME/Huawei/command-line-tools/sdk/default/openharmony"

# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  # homebrew (USTC mirrors)
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
fi
