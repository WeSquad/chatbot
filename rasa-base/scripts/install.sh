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

echo "downloading from en https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz"
./download-fasttext-vectors.sh en https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz
echo "./generate-models.sh fr"
./generate-models.sh fr

echo "downloading from fr https://s3-us-west-1.amazonaws.com/fasttext-vectors/word-vectors-v2/cc.fr.300.vec.gz"
./download-fasttext-vectors.sh fr https://s3-us-west-1.amazonaws.com/fasttext-vectors/word-vectors-v2/cc.fr.300.vec.gz
echo "./generate-models.sh fr"
./generate-models.sh fr