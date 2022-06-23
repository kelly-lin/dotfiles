#!/bin/zsh
# This script is only necessary because git will create a new worktree within
# the current worktree resulting in a recursive tree structure. This script
# ensures that the worktrees are created in the root git directory in order to
# achieve a flat worktree structure.

dir_name=$1
if [[ -z $dir_name ]]; then
  echo 'please provide a directory name for the worktree'
  exit 1
fi

branch_name=$2
if [[ -z $branch_name ]]; then
  echo 'please provide a branch name for the worktree'
  exit 1
fi

root_dir=$(git rev-parse --git-dir | sed 's/\.bare.*//')
cd $root_dir

git show-branch $branch_name &> /dev/null
[[ $? -ne 0 ]] && git branch $branch_name

git worktree add $dir_name $branch_name
