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

echo "install rasa requirements.txt"
#pip3 install -r $DIR/requirements.txt

pip3 install scipy==1.1.0
pip3 install 'cython>=0.24,<0.28.0'
pip3 install numpy>=1.15.0
pip3 install msgpack-numpy<0.4.4.0
pip3 install 'cymem>=1.30,<1.32'
pip3 install 'preshed>=1.0.0,<2.0.0'
pip3 install 'thinc>=6.10.3,<6.11.0'
pip3 install 'murmurhash>=0.28,<0.29'
pip3 install 'plac<1.0.0,>=0.9.6'
pip3 install ujson>=1.35
pip3 install 'dill>=0.2,<0.3'
pip3 install regex==2018.01.10
pip3 install 'requests>=2.13.0,<3.0.0'
pip3 install 'pytest>=3.6.0,<4.0.0'
pip3 install 'mock>=2.0.0,<3.0.0'
pip3 install pathlib==1.0.1
pip3 install spacy==2.0.11
pip3 install scikit-learn==0.19.1
pip3 install python_version<3.4