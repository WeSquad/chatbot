# Chatbot

Intelligent conversational [Botpress.io](https://botpress.io/) chatbot, [Articulate admin panel](https://samtecspg.github.io/articulate/) boosted with [FastText](https://fasttext.cc/) vectors and [Rasa NLU](https://rasa.com/).

## Table of contents

<!-- toc -->

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Future improvements](#future-improvements)
- [References](#references)

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
chmod +x install.sh
./install.sh
docker-compose up --build
```

## Usage

* [Botpress](http://localhost:3000) (login : admin / botpress)
* [Botpress chat interface](http://localhost:3000/s/chat)
* [Articulate](http://localhost:3333)
* [Articulate Swagger API](http://localhost:7500/documentation)
* [Duckling ping](http://localhost:8000)
* [Rasa NLU ping](http://localhost:5000)
* [Redis ping](http://localhost:6379)

## Future improvements

* [ ] Add credentials checking for Botpress
* [ ] Update Docker files with remote code instead of local
* [ ] Add commands for deployments
* [ ] Add example Rasa agent configuration
* [ ] Add guide for intents creation

## References

* [Botpress](https://github.com/botpress)
* [Articulate](https://github.com/samtecspg/articulate)
* [FastText](https://github.com/facebookresearch/fastText)
* [SpaCy](https://github.com/explosion/spaCy)
* [Rasa NLU](https://github.com/RasaHQ/rasa_nlu)
