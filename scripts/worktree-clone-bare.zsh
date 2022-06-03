#!/usr/bin/zsh
set -e

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

mkdir $name
cd "$name"

git clone --bare "$url" .bare
echo "gitdir: ./.bare" > .git
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin
