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

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache
    
RUN apk --no-cache add subversion python3-dev

WORKDIR ${RASA_NLU_HOME}

RUN pip3 install scipy==1.1.0
RUN pip3 install 'cython>=0.24,<0.28.0'
RUN pip3 install numpy>=1.15.0
RUN pip3 install msgpack-numpy==0.4.3.2
RUN pip3 install 'cymem>=1.30,<1.32'
RUN pip3 install 'preshed>=1.0.0,<2.0.0'
RUN pip3 install 'thinc>=6.10.3,<6.11.0'
RUN pip3 install 'murmurhash>=0.28,<0.29'
RUN pip3 install 'plac<1.0.0,>=0.9.6'
RUN pip3 install ujson>=1.35.1
RUN pip3 install 'dill>=0.2,<0.3'
RUN pip3 install regex==2018.01.10
RUN pip3 install 'requests>=2.13.0,<3.0.0'
RUN pip3 install 'pytest>=3.6.0,<4.0.0'
RUN pip3 install 'mock>=2.0.0,<3.0.0'
RUN pip3 install pathlib==1.0.1
RUN pip3 install spacy==2.0.11
RUN pip3 install scikit-learn==0.19.1

RUN pip uninstall --yes ujson
RUN pip3 uninstall --yes ujson
RUN git clone git://github.com/esnme/ultrajson.git && cd ultrajson && python3 setup.py install

RUN apk --no-cache add curl

COPY scripts/load_fastText.py ${RASA_NLU_HOME}/load_fastText.py
RUN chmod a+x ${RASA_NLU_HOME}/load_fastText.py
COPY scripts/prepare-models.sh ${RASA_NLU_HOME}/prepare-models.sh
RUN chmod a+x ${RASA_NLU_HOME}/prepare-models.sh

VOLUME ./models /app/models
VOLUME ./vectors /app/vectors
VOLUME ./scripts /app/scripts

