FROM python:3.7.3-alpine

ENV RASA_NLU_HOME=/app

# Installing deps
RUN apk add git bash --update-cache

WORKDIR ${RASA_NLU_HOME}

COPY scripts/requirements.txt ${RASA_NLU_HOME}/requirements.txt
COPY scripts/download-fasttext-vectors.sh ${RASA_NLU_HOME}/download-fasttext-vectors.sh
RUN chmod a+x ${RASA_NLU_HOME}/download-fasttext-vectors.sh
COPY scripts/generate-models.sh ${RASA_NLU_HOME}/generate-models.sh
RUN chmod a+x ${RASA_NLU_HOME}/generate-models.sh
COPY scripts/load_fastText.py ${RASA_NLU_HOME}/load_fastText.py
RUN chmod a+x ${RASA_NLU_HOME}/load_fastText.py
COPY scripts/prepare.sh ${RASA_NLU_HOME}/prepare.sh
RUN chmod a+x ${RASA_NLU_HOME}/prepare.sh

#RUN pip3 install -r ${RASA_NLU_HOME}/requirements.txt
#RUN pip3 install -e .


VOLUME ./models /app/models
VOLUME ./vectors /app/vectors
VOLUME ./scripts /app/scripts

