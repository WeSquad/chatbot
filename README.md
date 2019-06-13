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

To install the project, you must at first clone the code repository :

```sh
git clone https://github.com/WeSquad/chatbot.git
```

Then, this project can be installed by running the following commands (`sudo` might be needed):

```sh
cd chatbot
docker-compose up --build
```

wait unitl everything is up and run this :

```sh
docker run -it --rm rasa-build /app/install-requirements.sh
docker run -it --rm rasa-build /app/prepare-models.sh

docker exec -it chatbot_rasa-base /app/install.sh
```

## Usage

* [Articulate](http://localhost:3333)
* [Articulate Swagger API](http://localhost:7500/documentation)
* [Duckling ping](http://localhost:8000)
* [Rasa NLU ping](http://localhost:5000)
* [Redis ping](http://localhost:6379)

## References

* [Articulate](https://github.com/samtecspg/articulate)
* [FastText](https://github.com/facebookresearch/fastText)
* [SpaCy](https://github.com/explosion/spaCy)
* [Rasa NLU](https://github.com/RasaHQ/rasa_nlu)
