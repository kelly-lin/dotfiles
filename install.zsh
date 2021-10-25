#!/bin/zsh

echo "Installing alacritty config"
ln -s ./.alacritty.yml ~/.alacritty.yml

echo "Installing tmux config"
ln -s ./.tmux.conf ~/.tmux.conf

echo "Installing zsh config"
ln -s ./.zshrc ~/.zshrc

mkdir -p ~/.zsh
ln -s ./.alias.zsh ~/.zsh/.alias.zsh

echo "Install complete"
exit 0
