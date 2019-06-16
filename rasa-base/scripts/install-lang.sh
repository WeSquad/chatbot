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

LANGUAGE_PACKAGE=en

#############################################
## Functions
#############################################

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "${blue}Options:                      ${reset}"
  echo "${blue}          -l=en, --language-package=en         FastText language package, default is en${reset}"
  echo "${blue}          -h,  --help         help ${reset}"
  echo "${blue}                                   ${reset}"
  exit 1
}

install() {
    lang=$1
    pip install /app/models/$lang.tar.gz
    python -m spacy link $lang"_model" $lang
}


#############################################
## Check arguments
#############################################
for i in "$@"
  do
    case $i in
      -l=*|--language-package=*)       LANGUAGE_PACKAGE="${i#*=}"       ;;
      -h|--help)                   usage               ;;
      *)                           usage               ;;
    esac
done


install $LANGUAGE_PACKAGE