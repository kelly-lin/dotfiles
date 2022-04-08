#!/bin/zsh

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
