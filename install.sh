#!/bin/bash

# Current path
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load the conman script
. $DIR/conman.sh;

echo -e "\033[32m"
read -p "Install bash Config? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    . $DIR/bash/install.sh
fi

echo -e "\033[32m"
read -p "Install tmux Config? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    . $DIR/tmux/install.sh
fi

echo -e "\033[32m"
read -p "Install Vim Config? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    . $DIR/vim/install.sh
fi
