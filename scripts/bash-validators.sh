#!/usr/bin/env bash
#
# Basic validators that can be used with the bash-opt.sh script option parser
#
#-------------------------------------------------------------------------------
# Validate a string. (Must be non empty.)
#
# USAGE:> validate_string $STR
#
function validate_string()
{
    if [ ! "$1" ]
    then
        return 1
    else
        return 0
    fi  
}


#-------------------------------------------------------------------------------
# Validate an existing file.
#
# USAGE:> validate_file $FILE
#
function validate_file()
{
    if [ ! "$1" ] || [ ! -f "$1" ]
    then
        return 1
    else
        return 0
    fi  
}


#-------------------------------------------------------------------------------
# Validate an existing directory.
#
# USAGE:> validate_directory $DIR
#
function validate_directory()
{
    if [ ! "$1" ] || [ ! -d "$1" ]
    then
        return 1
    else
        return 0
    fi  
}