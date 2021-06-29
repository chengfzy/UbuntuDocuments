#!/bin/bash
# Compress Each Subfolders into a .7z File
#
# Usage:
#   compress_folder ROOT_FOLDER
#
# 1. The `ROOT_FOLDER` is root folder contains multiple subfolder to be compressed

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
    Compress Each Subfolders into a .7z File

    Usage: $0 [OPTIONS] ROOT_FOLDER
    
    Options:
        -h |help    Display help message
    
    ROOT_FOLDER     The root folder contains multiple projects
    
    Examples:
        ./compress_folder.sh ~/Documents/Code
EOT
}

# compress folder
function compress() {
    name=${1##*/}
    # -v mean natural sort, i.e., hidden file first
    for f in $(ls -v $1); do
        dir="$1/$f"
        if [ -d $dir ]; then
            # get folder size
            size=$(du -ms $dir | cut -f1)
            printf "\n${Green}Compress Folder: %s${NoColor}, %dM ..." $dir $size

            # compress with different command
            if [ $size -le 100 ]; then
                # 7z
                7z a -r $1/$f.7z $dir
            elif [ $size -le 1000 ]; then
                # tar
                tar -czf $1/$f.tar.gz $dir
            else
                # zip
                zip -rq9 $1/$f.zip $dir
            fi
        fi
    done
}

while getopts ":h" opt; do
    case $opt in
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

# parse root folder
if [ -z $1 ]; then
    usage
    exit 1
else
    folder=$1
fi

# parse options
printf "${BRed}========== Compress Each Subfolders into a .7z File ==========${NoColor}\n"
printf "${Cyan}  Root folder: %s${NoColor}\n" $folder

# recursive compress for each folder
compress $folder
