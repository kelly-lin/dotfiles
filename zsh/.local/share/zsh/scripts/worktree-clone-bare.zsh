#!/bin/zsh

set -e

url=$1
[[ -z $url ]] && echo 'please provide a git repo url' && exit 1

basename=${url##*/}
name=${2:-${basename%.*}}
[[ ! -z $2 ]] && name=$2

mkdir $name
cd "$name"

git clone --bare "$url" .bare
echo "gitdir: ./.bare" > .git
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin
