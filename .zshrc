export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

unsetopt CASE_GLOB

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
  if [[ `uname` == "Darwin" ]]; then
    alias ls='ls -G'
  elif ; then
    alias ls='ls --color=auto'
    alias ls='ls -G'
  fi

  alias ll='ls -alh'
  alias la='ls -ah'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'

  alias vim='nvim'
  alias vi='nvim'
  alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Enable colors for ls, less and man
  export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
  export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
  export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Dev env
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
  ## Start of Zinit's installer chunk
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

  # Zinit plugins
  zinit wait lucid for \
    MichaelAquilina/zsh-you-should-use \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting \
    lukechilds/zsh-nvm

  zinit ice depth=1
  zinit light jeffreytse/zsh-vi-mode
  zinit ice wait'!0' lucid
  zinit snippet OMZ::plugins/git/git.plugin.zsh
  zinit ice wait lucid atload'_zsh_autosuggest_start'
  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-syntax-highlighting # must be loaded last in plugins

# Plugin settings
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
  if [[ -f $HOME/.config/local-env.zsh ]]; then
    source ~/.config/local-env.zsh
  fi

  if [[ -f $HOME/.config/startup.sh ]]; then
    source ~/.config/startup.sh
  fi
