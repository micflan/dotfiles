#!/bin/bash

# List of files to be copied
FILES="tmux.conf"

# Source directory
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run the configuration manager
conman_copy "$FILES" "$SOURCE"

#
# All done!
#

echo -e "\033[32mEnjoy tmux!\033[0m\n"


