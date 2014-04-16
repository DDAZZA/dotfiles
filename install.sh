#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$PWD                                                              # dotfiles directory
olddir=~/dotfiles_old/`date '+%Y-%m-%d'`                              # old dotfiles backup directory
files="bashrc vimrc vim tmux.conf gitconfig gitignore gemrc rspec"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -ne "Creating $olddir"
mkdir -p $olddir/
echo " ...done"

# change to the dotfiles directory
cd $dir

# move existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  echo -ne "Moving ~/.$file to $olddir/$file"
  mv ~/.$file $olddir/$file
  echo " ...done"

  echo -ne "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/.$file
  echo " ...done"
  echo
done

if [ ! -f ~/.git-completion.sh ]; then
  echo 'Installing git completion'
  curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.sh
fi

if [ ! -f ~/.git-prompt.sh ]; then
  echo 'Installing git prompt'
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

source ~/.bashrc
