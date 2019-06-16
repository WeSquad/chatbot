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
docker-compose build rasa-base # this might take up to 15 minutes to build
```

The `rasa-build` and `rasa-base` images might take up to 1 hour to build because it installs may rasa dependencies.

3. We can now run the application :

```bash
cd chatbot
docker-compose up
```

Note that the containe `chatbot_rasa-base_1` will automatically launch the following command :
`/app/prepare-models.sh --language-package=fr`. This might take up to 1 hour, depdending on your machine resources.

4. Install languages from models :

```bash
cd chatbot
docker exec -it chatbot_rasa-base_1 ash /app/install-lang.sh --language-package=fr
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
