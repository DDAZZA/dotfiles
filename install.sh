#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -o nounset
readonly DIR=~/.dotfiles                                                             # dotfiles directory
readonly BACKUP_DIR=~/dotfiles_old/$(date '+%Y%m%d_%H%M%S')                      # old dotfiles backup directory
readonly FILES="bash_profile bashrc vimrc vim tmux.conf gitconfig gitignore gemrc rspec"     # list of files/folders to symlink in homedir

# change to the dotfiles directory
cd $DIR

# move existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $FILES; do
  if [ -L ~/.$file ]; then
    rm ~/.$file
  fi

  if [ -e ~/.$file ]; then
    mkdir -p $BACKUP_DIR/ && mv ~/.$file $BACKUP_DIR/$file
  fi

  echo "Installing: $file"
  ln -s $DIR/$file ~/.$file
done

if [ ! -f ~/.git-completion.sh ]; then
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.sh
fi

if [ ! -f ~/.git-prompt.sh ]; then
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
fi
