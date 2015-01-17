#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
set -o nounset
readonly DIR=$PWD                                                               # dotfiles directory
readonly BACKUP_DIR=~/dotfiles_old/$(date '+%Y%m%d_%H%M%S')                      # old dotfiles backup directory
readonly FILES="bashrc vimrc vim tmux.conf gitconfig gitignore gemrc rspec"     # list of files/folders to symlink in homedir
bold=`tput bold`
normal=`tput sgr0`

# change to the dotfiles directory
cd $DIR

# move existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $FILES; do
  if [[ -L "$file" ]]; then
    rm $file
  fi

  if [[ "$file" ]]; then
    mkdir -p $BACKUP_DIR/ && mv ~/.$file $BACKUP_DIR/$file
  fi

  echo "Installing ${bold}$file${normal}"
  ln -s $DIR/$file ~/.$file
done

if [[ ! -f ~/.git-completion.sh ]]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.sh
fi

if [[ ! -f ~/.git-prompt.sh ]]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

source ~/.bashrc
