#!/bin/zsh

prompt_cmd='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{196} <%f '
prompt_ins='%F{39}%~%f%F{243}$(parse_git_branch)%f%F{82} >%f '
prompt=$prompt_ins
ZSH_DISABLE_COMPFIX="true" # This is to ignore insecure directories

preexec() {
  timer=$(($(date +%s)))
}

prt() {
  echo $_exec_time
}

precmd() {
  if [ $timer ]; then
    now=$(($(date +%s)))
    elapsed=$(($now-$timer))

    _exec_time="${elapsed} seconds"
    unset timer
  fi

  # Add a new line after every command except the one after the terminal
  if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
      NEW_LINE_BEFORE_PROMPT=1
  elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
      echo
  fi
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
