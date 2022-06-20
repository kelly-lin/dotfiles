#!/bin/zsh

# Path
[[ -f $HOME/.config/zsh/path.zsh ]] && source $HOME/.config/zsh/path.zsh

# Set prompt
[[ -f $HOME/.config/zsh/prompt.zsh ]] && source $HOME/.config/zsh/prompt.zsh

# Set colors for less pager
[[ -f $HOME/.config/zsh/less.zsh ]] && source $HOME/.config/zsh/less.zsh

# Basic auto/tab complete
[[ -f $HOME/.config/zsh/completion.zsh ]] && source $HOME/.config/zsh/completion.zsh
  
# Options
[[ -f $HOME/.config/zsh/options.zsh ]] && source $HOME/.config/zsh/options.zsh

# Aliases
[[ -f $HOME/.config/zsh/alias.zsh ]] && source $HOME/.config/zsh/alias.zsh

# Source local configs
[[ -f $HOME/.config/zsh/.local/.zshrc ]] && source $HOME/zsh/.config/.local/.zshrc

# Plugins
[[ -f $HOME/.config/zsh/plugins.zsh ]] && source $HOME/.config/zsh/plugins.zsh
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Keybindings
[[ -f $HOME/.config/zsh/keybindings.zsh ]] && source $HOME/.config/zsh/keybindings.zsh
