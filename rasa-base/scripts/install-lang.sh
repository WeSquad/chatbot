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

LANGUAGE_PACKAGE=fr

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
    echo "install the model : pip install /app/models/$lang.tar.gz"
    pip install /app/models/$lang.tar.gz
    echo "load the model in spacy : python -m spacy link $lang"_model" $lang"
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