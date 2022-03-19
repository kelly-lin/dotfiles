#!/bin/zsh

which stow &> /dev/null
if [[ $? -ne 0 ]]; then
  echo 'Stow is not installed, please install stow to continue'
  exit 1
fi

echo "Installing tmux config"
stow --target=$HOME tmux

echo "Installing zsh config"
stow --target=$HOME zsh

echo "Installing nvim config"
stow --target=$HOME nvim

if [[ $OSTYPE == darwin* ]]; then
  echo "Installing alacritty config"
  cd ./alacritty
  stow --target=$HOME mac
  cd -

  echo "Installing fonts"
  cd ./fonts
  stow --target=$HOME mac
  cd -
fi

if [[ $OSTYPE == linux* ]]; then
  echo "Installing alacritty config"
  cd ./alacritty
  stow --target=$HOME linux
  cd -

  echo "Installing dunst config"
  stow --target=$HOME dunst

  echo "Installing i3 config"
  stow --target=$HOME i3

  echo "Installing polybar config"
  stow --target=$HOME polybar

  echo "Installing picom config"
  stow --target=$HOME picom

  echo "Installing logid"
  stow --target='/etc/' logid

  echo "Installing xfiles"
  stow --target=$HOME xfiles

  echo "Installing fonts"
  cd ./fonts
  stow --target=$HOME linux
  cd -
fi

echo "Install complete"
exit 0
