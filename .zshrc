export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

ZSH_DISABLE_COMPFIX="true" # This is to ignore insecure directories

# Prompt
## Get git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

## Enable substitution in the prompt.
setopt prompt_subst

## Set prompt
prompt_norm='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{196} <%f '
prompt_ins='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{82} >%f '
prompt=$prompt_norm

# Terminal colors
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Add a new line after every command except the one after the terminal
# initializes
precmd() {
  precmd() {
    echo
  }
}

 # Set colors for less pager
function man() {
  env \
    LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_mb=$(tput blink) \
    LESS_TERMCAP_us=$(tput setaf 2) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_so=$(tput smso) \
    LESS_TERMCAP_se=$(tput rmso) \
    PAGER="${commands[less]:-$PAGER}" \
    man "$@"
}

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}' # This makes autocomplete case insensitive

# Vim
export KEYTIMEOUT=1 # Reduces the delay between when you can start typing after switching vi modes

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

# Aliases
alias ls='ls --color=auto'
alias ll='ls -alh'
alias la='ls -ah'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Enable colors for ls, less and man
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Dev env
## Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Android Studio Tooling 
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

## Ruby
### Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Zinit
### Start of Zinit's installer chunk
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

## Load a few important annexes, without Turbo (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load plugins
source ~/.zsh/plugins/git.plugin.zsh
# source ~/.zsh/plugins/vi-mode.plugin.zsh

# Zinit plugins
zplugin ice depth=1
zplugin light jeffreytse/zsh-vi-mode
zplugin load MichaelAquilina/zsh-you-should-use
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-syntax-highlighting # must be loaded last in plugins

# Plugin settings
## Settings for vi-mode plugin
## Need these settings to render the change in cursor style when in
## insert/command mode
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

## zsh-vi-mode
## The plugin will auto execute this `zvm_after_select_vi_mode` function
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      prompt=$prompt_norm
      ;;
    $ZVM_MODE_INSERT)
      prompt=$prompt_ins
      ;;
  esac
}

# Execute custom system env scripts
source ~/.config/startup.sh
