#!/bin/bash

# List of files to be copied
FILES="vimrc.bundles vimrc.bundles.local vimrc.common vimrc"

# Source directory
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Optionally include the .vim folder
echo -e "\033[32m"
read -p "Install clean .vim folder? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    FILES="$FILES vim"
fi

# Run the configuration manager
conman_copy "$FILES" "$SOURCE"

# Install Vundle
echo -e "\033[36mInstalling Vundle... \033[0m"
if [ ! -d $DESTINATION/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git $DESTINATION/.vim/bundle/vundle
    echo -e "\033[92mDone.\033[0m\n"
else
    echo -e "\033[92mVundle already installed.\033[0m\n"
fi

# Optionally install bundles
echo -e "\033[32m"
read -p "Install vim bundles now? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\033[36mInstalling Bundles... \033[0m"
    vim +BundleClean +BundleInstall +BundlesUpdate +qall
    echo -e "\033[92mDone.\033[0m\n"
fi

#
# All done!
#

echo -e "\033[32mEnjoy Vim!\033[0m\n"

