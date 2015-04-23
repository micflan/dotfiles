#!/bin/bash

# # # CONMAN: Configuration Manager # # #
#
# Backup and replace (dot) files
#
# @usage: conman "$FILES" "$SOURCE" ["$DESTINATION"=~] ["$LOCALFILE"]
#

function conman_copy {

    #
    # Defaults and missing variables check
    #

    # Files list ($1)
    if [ -z "$1" ]
    then
        echo -e "\033[31m\$1:FILES is a required variable.\033[0m"
        exit 0;
    else
        FILES=$1
    fi

    # Source location ($2)
    if [[ -z "$2" ]] || [[ ! -d $2 ]]
    then
        echo -e "\033[31m\$1:SOURCE is a required variable and must be a valid path.\033[0m"
        exit 0;
    else
        SOURCE=$2
    fi

    # Destination directory ($3)
    if [ -z "$3" ]
    then
        DESTINATION=~
    elif [ ! -d $3 ]
    then
        echo -e "\033[31m\$3:DESTINATION must be a valid path.\033[0m"
        exit 0;
    else
        DESTINATION=$3
    fi

    # Name of the local file (e.g. bash_local) ($4)
    if [ -n "$4" ]
    then
        LOCALFILE=$4
    fi

    #
    # Backup existing files
    #

    # Location of backups
    BACKUP_DIR="$SOURCE/backup/$HOSTNAME"

    echo -e "\n\033[36mBacking up existing config... \033[0m"

    # Timestamp for backups
    TIMESTAMP=$(date +%s)
    BACKUP_DIR=$BACKUP_DIR/$TIMESTAMP

    # Create backup directory if required
    mkdir -vp $BACKUP_DIR

    # Loop through our list of files
    # If an original exists at destination,
    # then move it to backup
    for fn in $FILES
    do
        if [ -e $DESTINATION/.$fn ]
        then
            mv -v $DESTINATION/.$fn $BACKUP_DIR/
        fi
    done

    echo -e "\033[32mDone.\033[0m\n"

    #
    # Copy files for user
    #

    echo -e "\033[36mCopying files... \033[0m"

    # Loop through our list of files
    # If the file exists
    # copy it to users config directory
    for fn in $FILES
    do
        if [ -e $SOURCE/dot/$fn ]
        then
            cp -rv $SOURCE/dot/$fn $DESTINATION/.$fn
        fi
    done

    # Perform actions for local file if required
    if [ -n "$LOCALFILE" ]
    then
        # Create new host file if required
        if [ ! -f $SOURCE/local/$HOSTNAME ]; then
            touch $SOURCE/local/$HOSTNAME
        fi

        # Copy host specific file to destination
        cp -r $SOURCE/local/$HOSTNAME $DESTINATION/.$LOCALFILE
    fi

    echo -e "\033[32mDone.\033[0m\n"
}
