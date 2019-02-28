#!/bin/sh
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip3 install --upgrade pip
DIR="$( cd "$( dirname "$0" )" && pwd )"
pip3 install -r $DIR/rasa_fasttext/requirements.txt
sh $DIR/rasa/download.sh fr https://s3-us-west-1.amazonaws.com/fasttext-vectors/word-vectors-v2/cc.fr.300.vec.gz
sh $DIR/rasa/generate.sh fr
