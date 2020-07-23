#!/bin/bash
# Garbage Collection for git Project
#
# Usage:
#   git_gc PROJECT_FOLDER
#
# 1. The `PROJECT_FOLDER` is the project folder, or the root folder contains multiple projects

# variables
folder=""
pull=0 # whether to use git pull

# regular colors
Red='\033[0;31m'
Green='\033[0;32m'
Orange='\033[0;33m'
Blue='\033[0;34m'
Magenta='\033[0;35m'
Cyan='\033[0;36m'
# bold color
BRed='\033[1;31m'
BGreen='\033[1;32m'
BOrange='\033[1;33m'
BBlue='\033[1;34m'
BMagenta='\033[1;35m'
BCyan='\033[1;36m'
# no color, default
NoColor='\033[0m'

function usage() {
    cat <<-EOT
    Garbage collection for git projects

    Usage: $0 [OPTIONS] PROJECT_FOLDER
    
    Options:
        -p |pull    Use git pull before garbage collection
        -h |help    Display help message
    
    PROJECT_FOLDER  Project folder, could be the root folder contains multiple projects
    
    Examples:
        ./git_gc.sh ~/Documents/Code
EOT
}

# garbage collection
function gc() {
    name=${1##*/}
    if [ "$name" = ".git" ]; then
        cd $1
        cd ..
        if [ $pull = 1 ]; then
            printf "\n${BCyan}Pull: %s${NoColor}\n" $1
            git pull
        fi
        printf "\n${BCyan}GC: %s${NoColor}\n" $1
        git gc --prune=now
    else
        # -v mean natural sort, i.e., hidden file first
        for f in $(ls -av $1); do
            dir="$1/$f"
            if [ -d $dir ]; then
                if [ "$f" = ".git" ]; then
                    gc $dir
                    break
                elif [[ "$f" != "." && "$f" != ".." ]]; then
                    gc $dir
                fi
            fi
        done
    fi
}

while getopts ":ph" opt; do
    case $opt in
    p)
        pull=1
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    esac
done

shift $(($OPTIND - 1))

# parse project folder
if [ -z $1 ]; then
    usage
    exit 1
else
    folder=$1
fi

# parse options
printf "${BRed}========== Garbage Collection for git Project ==========${NoColor}\n"
printf "${Cyan}  Project folder: %s${NoColor}\n" $folder
if [ $pull = 1 ]; then
    printf "${Cyan}  Use git pull before gc${NoColor}\n"
fi

# recursive gc for each folder
gc $folder
