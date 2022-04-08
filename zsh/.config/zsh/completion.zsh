#!/bin/zsh

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}' # This makes autocomplete case insensitive
