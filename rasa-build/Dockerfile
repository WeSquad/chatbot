FROM alpine

ENV RASA_RELEASE=0.13.1 \
    RASA_NLU_HOME=/app \
    RASA_NLU_PYTHON_PACKAGES=/usr/local/lib/python2.7/dist-packages

# Installing deps
RUN apk --update add --virtual scipy-runtime python py-pip \
    && apk add --virtual scipy-build \
        build-base python-dev openblas-dev freetype-dev pkgconfig gfortran \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install --upgrade pip
RUN pip install --no-cache-dir scipy \
    && apk add --virtual scipy-runtime \
        freetype libgfortran libgcc libpng  libstdc++ musl openblas tcl tk \
    && rm -rf /var/cache/apk/*
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

