#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
set -o nounset
set -o errexit

readonly DIR=$PWD                                                               # dotfiles directory
readonly BACKUP_DIR=~/dotfiles_old/$(date '+%Y-%m-%d')                              # old dotfiles backup directory
readonly FILES="bashrc vimrc vim tmux.conf gitconfig gitignore gemrc rspec"     # list of files/folders to symlink in homedir


# create dotfiles_old in homedir
echo -ne "Creating $BACKUP_DIR"
mkdir -p $BACKUP_DIR/
echo " ...done"

# change to the dotfiles directory
cd $DIR

# move existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $FILES; do
  echo -ne "Moving ~/.$file to $BACKUP_DIR/$file"
  mv ~/.$file $BACKUP_DIR/$file
  echo " ...done"

  echo -ne "Creating symlink to $file in home directory"
  ln -s $DIR/$file ~/.$file
  echo " ...done"
  echo
done

if [[ ! -f ~/.git-completion.sh ]]; then
  echo 'Installing git completion'
  curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.sh
fi

if [[ ! -f ~/.git-prompt.sh ]]; then
  echo 'Installing git prompt'
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

source ~/.bashrc
