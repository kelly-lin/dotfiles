#!/bin/zsh
echo "Please enter the number for the config to upload (1 - zsh, 2 - tmux, 3 - vim, 4 - all)"
read config
case $config in
  1)
    echo "Uploading zsh config..."
    files=(".zshrc")
    ;;
  2)
    echo "Uploading tmux config..."
    files=(".tmux.conf")
    ;;
  3)
    echo "Uploading vim config..."
    files=(".vimrc")
    ;;
  4)
    echo "Uploading all configs"
    files=(".zshrc" ".tmux.conf" ".vimrc")
    ;;
  *)
    echo "Invalid selection, exiting..."
    exit 1
esac

echo "Copying files to repository..."
for filename in "${files[@]}"
do
  cp ~/$filename ./$filename
  git add $filename 
done

echo "Commiting to repository and pushing to remote"
git commit -m "update $files"
git push origin master

echo "Update complete"
exit 0
