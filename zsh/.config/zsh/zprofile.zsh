#!/bin/zsh

if [[ `uname` == Linux* ]] && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
