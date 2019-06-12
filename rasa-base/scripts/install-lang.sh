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

PACKAGE_PATH=/app/models
LANG_PACKAGE=en

#############################################
## Functions
#############################################

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "${blue}Options:                      ${reset}"
  echo "${blue}          -l, --language      FastText language package, default is en${reset}"
  echo "${blue}          -p, --path          Path to the language package, default is /app/models${reset}"
  echo "${blue}          -h,  --help         help ${reset}"
  echo "${blue}                                   ${reset}"
  exit 1
}

install() {
    lang = $1
    $package_path = $2
    pip install $package_path/$lang.tar.gz
    python -m spacy link $lang_model $lang
}


#############################################
## Check arguments
#############################################
for i in "$@"
  do
    case $i in
      -l=*|--lang=*)       LANG_PACKAGE="${i#*=}"       ;;
      -p=*|--path=*)       PACKAGE_PATH="${i#*=}"       ;;
      -h|--help)                   usage               ;;
      *)                           usage               ;;
    esac
done


install $LANGUAGE $PACKAGE_PATH 