#!/bin/zsh
echo "Please enter the number for the config to sync (1 - zsh, 2 - tmux, 3 - vim, 4 - all)"
read config
case $config in
  1)
    echo "Updating zsh config..."
    files=(".zshrc")
    ;;
  2)
    echo "Updating tmux config..."
    files=(".tmux.conf")
    ;;
  3)
    echo "Updating vim config..."
    files=(".vimrc")
    ;;
  4)
    echo "Updating all configs"
    files=(".zshrc" ".tmux.conf" ".vimrc")
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
for filename in "${files[@]}"
do
  cp ./$filename ~/$filename 
done

echo "Sync complete"
exit 0
