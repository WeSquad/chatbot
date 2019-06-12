#!/bin/sh

echo not supposed to execute anything here 
exit

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip3 install --upgrade pip
DIR="$( cd "$( dirname "$0" )" && pwd )"
pip3 install -r $DIR/rasa/requirements.txt

cd $DIR/rasa
sh ./download.sh fr https://s3-us-west-1.amazonaws.com/fasttext-vectors/word-vectors-v2/cc.fr.300.vec.gz
sh ./generate.sh fr
sh ./download.sh en https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz
sh ./generate.sh en

cd $DIR/rasa-fr
sh ../rasa/download.sh fr https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz
sh ../rasa/generate.sh fr

cd $DIR/rasa-en 
sh ../rasa/download.sh en https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.en.300.vec.gz
sh ../rasa/generate.sh en