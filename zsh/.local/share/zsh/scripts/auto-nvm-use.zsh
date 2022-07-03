#!/bin/zsh

[[ -z $(command -v jq) ]] && \
  echo 'jq is a required dependecy, please install jq to use this script' && \
  exit 0
[[ -z $(command -v nvm) ]] && \
  echo 'nvm is a required dependecy, please install nvm to use this script' && \
  exit 0

[[ ! -f package.json ]] && echo 'no package.json file found' && exit 0

nodeVersion=$(jq -r '.engines.node | select(.!=null)' package.json )
if [[ ! -z $nodeVersion ]] && [[ ! $(nvm current) = "^v$nodeVersion" ]]; then
  echo "found $nodeVersion in package.json engine"
  nvm use ${nodeVersion:0:2}
fi
