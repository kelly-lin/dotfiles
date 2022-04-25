# Set default programs
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Terminal colors
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Misc
export KEYTIMEOUT=10 # Reduces the delay between when you can start typing after switching vi modes

# Setup Cargo env
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

# Enable colors for ls, less and man
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Path
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:$HOME/Applications/nvim/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

# Android Studio Tooling
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Ruby Version Manager (needs to be at the end of path)
export PATH=$PATH:$HOME/.rvm/bin

[[ -f $HOME/.local/zsh/.zshenv ]] && source $HOME/.local/zsh/.zshenv