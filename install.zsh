#!/bin/zsh
install_vim="./scripts/install-vim-config.zsh"
install_tmux="./scripts/install-tmux-config.zsh"
install_zsh="./scripts/install-zsh-config.zsh"

echo "Please enter the number for the config to sync (1 - zsh, 2 - tmux, 3 - vim, 4 - all)"
read config
case $config in
  1)
    echo "Updating zsh config..."
    installs=($install_zsh)
    ;;
  2)
    echo "Updating tmux config..."
    installs=($install_tmux)
    ;;
  3)
    echo "Updating vim config..."
    installs=($install_vim)
    ;;
  4)
    echo "Updating all configs"
    installs=($install_vim $install_zsh $install_tmux)
    ;;
  *)
    echo "Invalid selection, exiting..."
    exit 1
esac

echo "Pulling remote repository"
git reset --hard HEAD
git checkout master
git pull origin master

echo "Copying files..."
for install in "$installs[@]"
do
  source install
done

echo "Install complete"
exit 0
