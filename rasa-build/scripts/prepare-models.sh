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
DOWNLAD_VECTORS=true
GENERATE_MODELS=true

#############################################
## Functions
#############################################

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "${blue}Options:                      ${reset}"
  echo "${blue}          -l=en, --language-package=en         FastText language package, default is en${reset}"
  echo "${blue}          -d=true, --download-vectors=true     Download vectors or not, default is true${reset}"
  echo "${blue}          -g=true, --generate-models=true      Generate models or not, default is true${reset}"
  echo "${blue}          -h,  --help         help ${reset}"
  echo "${blue}                                   ${reset}"
  exit 1
}

download-fasttext-vectors() {
    lang=$1
    url=$2
    dest_dir=$3

    mkdir -p $dest_dir
    dest_path=$dest_dir/$lang.vec.gz
    echo "curl $url -o $dest_path"
    curl $url -o $dest_path
    echo "Extracting downloaded vectors ... Please wait !"
    echo gzip -d $dest_path
    gzip -d $dest_path
}

generate-models() {
    lang=$1
    vectors_path=$2
    models_path=$3

    echo "Loading FastText vectors "$lang" ... Please wait !"
    python3 $DIR/load_fastText.py $vectors_path/$1/$1.vec $1

    echo "Generating "$lang" model ... Please wait !"
    mkdir -p $models_path/tmp
    python3 -m spacy package $vectors_path/$lang/ $models_path/tmp

    cd $models_path/tmp/$lang"_model-0.0.0"
    python3 setup.py sdist
    mv $models_path/tmp/$lang"_model-0.0.0"/dist/$lang"_model-0.0.0".tar.gz $dest/$lang.tar.gz
    rm -Rf $models_path/tmp/$lang"_model-0.0.0"/
}

download-generate() {
  lang=$1
  download=$2
  generate=$3

  if [ x"$download" == "xtrue" ]; then 
    url=https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.$lang.300.vec.gz
    mkdir -p /app/vectors/$lang
    download-fasttext-vectors $lang $url /app/vectors/$lang
  fi

  if [ x"$generate" == "xtrue" ]; then 
    mkdir -p /app/models/$lang
    generate-models $lang '/app/vectors' '/app/models' 
  fi
}

#############################################
## Check arguments
#############################################
for i in "$@"
  do
    case $i in
      -l=*|--language-package=*)   LANGUAGE_PACKAGE="${i#*=}"       ;;
      -d=*|--download-vectors=*)   DOWNLAD_VECTORS="${i#*=}"       ;;
      -g=*|--generate-models=*)    GENERATE_MODELS="${i#*=}"       ;;
      -h|--help)                   usage               ;;
      *)                           usage               ;;
    esac
done

download-generate $LANGUAGE_PACKAGE $DOWNLAD_VECTORS $GENERATE_MODELS
