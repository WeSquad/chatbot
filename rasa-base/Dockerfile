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

# Installing Rasa
RUN wget -O - https://github.com/RasaHQ/rasa_nlu/archive/${RASA_RELEASE}.tar.gz | zcat | tar xvf -
RUN mv rasa-${RASA_RELEASE} ${RASA_NLU_HOME}

WORKDIR ${RASA_NLU_HOME}

# Installing SpaCy deps
RUN sed -i '/matplotlib/d' alt_requirements/requirements_bare.txt
RUN sed -i '/numpy/d' alt_requirements/requirements_bare.txt
RUN pip install -r alt_requirements/requirements_spacy_sklearn.txt
RUN pip install -e .

# There is a bug relating to usjon : https://github.com/esnme/ultrajson/issues/326
RUN pip uninstall --yes ujson
RUN git clone git://github.com/esnme/ultrajson.git && cd ultrajson && python setup.py install

COPY conf/config_spacy_duckling.yml ${RASA_NLU_HOME}/config.yml

COPY scripts/install-lang.sh ${RASA_NLU_HOME}/install-lang.sh
RUN chmod a+x ${RASA_NLU_HOME}/install-lang.sh

VOLUME ./models /app/models
VOLUME ./vectors /app/vectors
VOLUME ./scripts /app/scripts
VOLUME ./conf /app/conf

# Exposing resources
EXPOSE 5000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["start", "--path", "/app/nlu-model", "-c", "config.yml", "--max_training_processes", "1"]
