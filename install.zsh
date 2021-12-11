#!/bin/zsh

dir=${0:a:h}

echo "Installing alacritty config"
ln -s -f $dir/alacritty/alacritty.yml ~/.alacritty.yml

echo "Installing tmux config"
ln -s -f $dir/tmux/tmux.conf ~/.tmux.conf

echo "Installing zsh config"
ln -s -f $dir/zsh/zshrc ~/.zshrc

mkdir -p ~/.zsh
ln -s -f $dir/zsh/alias.zsh ~/.zsh/.alias.zsh

echo "Installing dunst config"
ln -s -f $dir/config/dunst ~/.config/dunst

echo "Installing i3 config"
ln -s -f $dir/config/i3 ~/.config/i3

echo "Installing nvim config"
ln -s -f $dir/config/nvim ~/.config/nvim

echo "Installing picom config"
ln -s -f $dir/config/picom ~/.config/picom

echo "Installing polybar config"
ln -s -f $dir/config/polybar ~/.config/polybar

echo "Install complete"
exit 0
