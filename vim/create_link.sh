#!/bin/sh
# updates global vimrc
# WARNING THIS DELETES THE CURRENT .vimrc FILE

rm ~/.vimrc
echo "Removed ~/.vimrc"
ln -s .vimrc ~/.vimrc
echo "created link ~/.vimrc"
