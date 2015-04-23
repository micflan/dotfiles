#!/bin/bash

# List of files to be copied
FILES="bash_profile bash_aliases bash_logout bashrc inputrc bash_common"

# Source directory
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run the configuration manager
conman_copy "$FILES" "$SOURCE"

#
# Optionally install binaries to ~/bin
#

echo -e "\033[32m"
read -p "Install binaries to ~/bin? " -n 1 -r
echo -e "\033[0m"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -v ~/.bin
    cp -iv $SOURCE/dot/bin/* ~/.bin/
fi

#
# All done!
#

source ~/.bashrc
echo -e "\033[32mEnjoy Bash!\033[0m\n"

