#!/bin/zsh


# Set zsh options
  unsetopt BEEP
  setopt prompt_subst
  unsetopt CASE_GLOB

# History in cache directory
  HISTSIZE=10000
  SAVEHIST=10000
  HISTFILE=~/.cache/zsh/history

# Vim
  ## 'jk' to exit insert mode
  bindkey -M viins 'jk' vi-cmd-mode

  ## Use vim keys in tab complete menu
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -v '^?' backward-delete-char

  ## Edit line in vim by pressing 'v' in command mode
  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd v edit-command-line
