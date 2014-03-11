#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$PWD                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim tmux.conf gitconfig gitignore gemrc rspec"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -ne "Creating $olddir for backup of any existing dotfiles in ~/"
mkdir -p $olddir
echo " ...done"

# change to the dotfiles directory
echo -ne "Changing to $dir directory"
cd $dir
echo " ...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  echo -ne "Moving ~/.$file to $olddir/$file"
  mv ~/.$file ~/dotfiles_old/
  echo " ...done"

  echo -ne "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/.$file
  echo " ...done"
  echo
done
