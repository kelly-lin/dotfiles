#!/bin/zsh

[[ ! -f 'package.json' ]] && exit 0

[[ -f 'yarn.lock' ]] && yarn && exit 0

npm install
