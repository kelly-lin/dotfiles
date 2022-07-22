#/bin/zsh

target=$(fd -H -t f . | grep -v '^\./\.git' | fzf)
[[ -z $target ]] && exit 0
$EDITOR $target
