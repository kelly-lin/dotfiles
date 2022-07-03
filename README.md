# dotfiles

This repository contains my config dot files for applications such has Neovim,
zsh and tmux. 

You can pick and choose what you want from the config files or you can simply
install them all by following the install instructions. 

Use and share as you please.

## Dependencies

- stow
- Ansible

## Installing

### dotfiles
Run `./install.py stow` in the root directory.

### Packages

`ansible-playbook -i ./.ansible/hosts ./.ansible/playbook.yml --ask-become-pass`
