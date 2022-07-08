#!/bin/zsh

# since we this script needs to be sourced to work and we need to save the
# result from fzf into a variable, we need to save and restore the variable 
# incase something was already stored in it.
prev=$dir
dir=$(fd -H -t d . | grep -v '.git' | grep -v 'node_modules' | fzf)
[[ ! -z $dir ]] && cd $dir
dir=$prev
