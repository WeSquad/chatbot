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

LANG_PACKAGE=en
MODELS_PATH=/app/models
VECTORS_PATH=/app/vectors

#############################################
## Functions
#############################################

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "${blue}Options:                      ${reset}"
  echo "${blue}          -l, --language      FastText language package, default is en${reset}"
  echo "${blue}          -m, --models-path   Path to the dest models, default is /app/models${reset}"
  echo "${blue}          -v, --vectors-path  Path to the source vectors, default is /app/vectors${reset}"
  echo "${blue}          -h,  --help         help ${reset}"
  echo "${blue}                                   ${reset}"
  exit 1
}

install() {
    lang=$1
    vectors_path=$2
    models_path=$3

    echo "Loading FastText vectors "$lang" ... Please wait !"
    python3 $DIR/load_fastText.py $vectors_path/$1/$1.vec $1

    echo "Generating "$lang" model ... Please wait !"
    mkdir -p $Dmodels_path/tmp
    python3 -m spacy package $vectors_path/$lang/ $models_path/tmp

    cd $models_path/tmp/$lang_model-0.0.0
    python3 setup.py sdist
    mv $models_path/tmp/$lang_model-0.0.0/dist/$lang_model-0.0.0.tar.gz $dest/$lang.tar.gz
    rm -Rf $models_path/tmp/$lang_model-0.0.0/
}


#############################################
## Check arguments
#############################################
for i in "$@"
  do
    case $i in
      -l=*|--lang=*)               LANG_PACKAGE="${i#*=}"       ;;
      -m=*|--models-path=*)        MODELS_PATH="${i#*=}"       ;;
      -v=*|--vectors-path=*)       VECTORS_PATH="${i#*=}"       ;;
      -h|--help)                   usage               ;;
      *)                           usage               ;;
    esac
done


install $LANG_PACKAGE $VECTORS_PATH $MODELS_PATH

