# Add key binding for Ranager
  bindkey -s '^p' 'ranger\n'

# Set zsh options
  unsetopt BEEP
  setopt prompt_subst
  unsetopt CASE_GLOB

# Set prompt
  prompt_cmd='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{196} <%f '
  prompt_ins='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{82} >%f '
  prompt=$prompt_ins
  ZSH_DISABLE_COMPFIX="true" # This is to ignore insecure directories

  # Add a new line after every command except the one after the terminal
    precmd() {
      precmd() {
        echo
      }
    }

  # Change zle cursor style when in the different vim modes
  set_prompt() {
    case $KEYMAP in
      vicmd)
        prompt=$prompt_cmd
        echo -ne '\e[2 q'
        ;;
      viins|main)
        prompt=$prompt_ins
        echo -ne '\e[6 q'
        ;;
    esac
    zle reset-prompt
  }

  zle-keymap-select () {
    set_prompt
  }
  zle -N zle-keymap-select

  zle-line-init() {
    set_prompt
  }
  zle -N zle-line-init

  ## Get git branch
  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
  }

# History in cache directory
  HISTSIZE=10000
  SAVEHIST=10000
  HISTFILE=~/.cache/zsh/history

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
  
# Aliases
  [[ -f $HOME/.config/zsh/alias.zsh ]] && source $HOME/.config/zsh/alias.zsh

# Zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

  # Zinit plugins
  zinit wait lucid for \
    MichaelAquilina/zsh-you-should-use \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting \
    lukechilds/zsh-nvm

  zinit ice wait'!0' lucid
  zinit snippet OMZ::plugins/git/git.plugin.zsh
  zinit ice wait lucid atload'_zsh_autosuggest_start'
  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-syntax-highlighting # must be loaded last in plugins

# Source local configs
[[ -f $HOME/.local/zsh/.zshrc ]] && source $HOME/.local/zsh/.zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
