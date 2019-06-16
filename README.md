# Chatbot

Intelligent conversational chatbot with [Articulate admin panel](https://samtecspg.github.io/articulate/) boosted with [FastText](https://fasttext.cc/) vectors and [Rasa NLU](https://rasa.com/).

## Table of contents

<!-- toc -->

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [References](#references)

<!-- tocstop -->

## Requirements

FastText and SpaCy require [Python v3](https://www.python.org/downloads/) to load vectors as models.

To clone the project properly you need [Git CLI](https://git-scm.com/downloads) installed.

In order to run Docker containers the following tools are needed :

* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

Language models generation can be done entirely in Docker but containers have fewer resources than the host machine, Fasttext compression is much faster via Python.

1. To install the project, you must at first clone the code repository :

```bash
git clone https://github.com/WeSquad/chatbot.git
```

2. As we are using Docker, we need to first build the docker images required to run the applications :

```bash
cd chatbot
docker-compose build # this might take up to 1 hour to build
```

As an option, as it's a bit long to build, you may want to build seperatedly :

```bash
cd chatbot
docker-compose build rasa-build # this might take up to 1 hour to build
docker-compose build rasa # this might take up to 15 minutes to build
```

The `rasa` and `rasa-build` images might take up to 1 hour to build because it installs may rasa dependencies.

3. We can now run the application :

```bash
cd chatbot
host=$(hostname) docker-compose up -d
```

Note that the containe `chatbot_rasa_1` will automatically launch the following command :
`/app/prepare-models.sh --language-package=fr`. This might take up to 1 hour, depdending on your machine resources.

The models is generated when we got this :

```bash
docker logs -f chatbot_rasa-build_1

...

copying files to en_model-0.0.0...
copying en_model/meta.json -> en_model-0.0.0/en_model
copying en_model.egg-info/PKG-INFO -> en_model-0.0.0/en_model.egg-info
copying en_model.egg-info/SOURCES.txt -> en_model-0.0.0/en_model.egg-info
copying en_model.egg-info/dependency_links.txt -> en_model-0.0.0/en_model.egg-info
copying en_model.egg-info/requires.txt -> en_model-0.0.0/en_model.egg-info
copying en_model.egg-info/top_level.txt -> en_model-0.0.0/en_model.egg-info
copying en_model/en_model-0.0.0/meta.json -> en_model-0.0.0/en_model/en_model-0.0.0
Writing en_model-0.0.0/setup.cfg
Creating tar archive
removing 'en_model-0.0.0' (and everything under it)
Moving en model to /app/models/en.tar.gz ... Please wait !
```

4. Install languages from models :

Before executing the next command, make sure the step 3 is done.

```bash
cd chatbot
docker exec -it chatbot_rasa_1 ash /app/install-lang.sh --language-package=fr
```

```bash
docker logs -f chatbot_rasa_1

...

Requirement already satisfied: six<2.0.0,>=1.10.0 in /usr/lib/python2.7/site-packages (from thinc<6.11.0,>=6.10.1->spacy>=>=2.0.11->en-model==0.0.0) (1.11.0)
Requirement already satisfied: toolz>=0.8.0 in /usr/lib/python2.7/site-packages (from cytoolz<0.10,>=0.9.0->thinc<6.11.0,>=6.10.1->spacy>=>=2.0.11->en-model==0.0.0) (0.9.0)
Installing collected packages: en-model
  Running setup.py install for en-model ... done
Successfully installed en-model-0.0.0
```

## Usage

* [Articulate](http://localhost:3000)
* [Articulate Swagger API](http://localhost:7500/documentation)
* [Duckling ping](http://localhost:8000)
* [Rasa NLU ping](http://localhost:5000)
* [Redis ping](http://localhost:6379)

## References

* [Articulate](https://github.com/samtecspg/articulate)
* [FastText](https://github.com/facebookresearch/fastText)
* [SpaCy](https://github.com/explosion/spaCy)
* [Rasa NLU](https://github.com/RasaHQ/rasa_nlu)
