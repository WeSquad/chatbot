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

#############################################
## Functions
#############################################

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

lang=en
url='https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz'
mkdir -p /app/vectors/$lang
download-fasttext-vectors $lang $url /app/vectors/$lang

mkdir -p /app/models/$lang
./generate-models.sh -l=en -m='/app/models' -v='/app/vectors'


lang=fr
url='https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.fr.300.vec.gz'
mkdir -p /app/vectors/$lang
download-fasttext-vectors $lang $url /app/vectors/$lang

mkdir -p /app/models/$lang
./generate-models.sh -l=en -m='/app/models' -v='/app/vectors'
