#!/bin/sh

#!/bin/bash

#############################################
## Global variables
#############################################
if [ -x /usr/bin/tput ]; then
  red=`tput setaf 1` # error
  green=`tput setaf 2` # nice
  yellow=`tput setaf 3` # warning
  blue=`tput setaf 4` # info
  purple=`tput setaf 5` # command
  teal=`tput setaf 6` # detail
  white=`tput setaf 7` #
  reset=`tput sgr0`
fi

DIR=${0%/*}
echo "current dir: " $DIR

if [ ! -d "$DIR" ]; then DIR="$PWD"; fi


URL=https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz
LANG_PACKAGE=en
DEST=/app/vectors

#############################################
## Functions
#############################################

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "${blue}Options:                      ${reset}"
  echo "${blue}          -l, --language      FastText language package, default is en${reset}"
  echo "${blue}          -u, --url           URL to the FastText vectors gzip file${reset}"
  echo "${blue}          -h,  --help         help ${reset}"
  echo "${blue}                                   ${reset}"
  exit 1
}

install() {
    lang=$1
    url=$2
    dest=$3

    mkdir -p $dest/$lang
    echo "download from $url"
    wget -O $dest/$lang/$lang.vec.gz $url
    echo "Extracting downloaded vectors ... Please wait !"
    gzip -d $dest/$1/$1.vec.gz
}


#############################################
## Check arguments
#############################################
for i in "$@"
  do
    case $i in
      -l=*|--lang=*)       LANG_PACKAGE="${i#*=}"       ;;
      -u=*|--url=*)        URL="${i#*=}"       ;;
      -d=*|--url=*)        DEST="${i#*=}"       ;;
      -h|--help)                   usage               ;;
      *)                           usage               ;;
    esac
done


install $LANG_PACKAGE $URL 
