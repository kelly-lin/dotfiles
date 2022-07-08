#!/bin/zsh

_dir=$(fd -H -t d . | fzf)
[[ ! -z $_dir ]] && cd $_dir
