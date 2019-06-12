FROM rasa-base:latest

ENV RASA_NLU_HOME=/app \
    RASA_NLU_PYTHON_PACKAGES=/usr/local/lib/python2.7/dist-packages

WORKDIR ${RASA_NLU_HOME}

# Installing SpaCy deps
RUN sed -i '/matplotlib/d' alt_requirements/requirements_bare.txt
RUN sed -i '/numpy/d' alt_requirements/requirements_bare.txt
RUN pip install -r alt_requirements/requirements_spacy_sklearn.txt
RUN pip install -e .

# Installing FR lang package
COPY ./models/fr.tar.gz ${RASA_NLU_HOME}
RUN pip install ${RASA_NLU_HOME}/fr.tar.gz
RUN python -m spacy link fr_model fr
RUN rm fr.tar.gz

# Installing EN lang package
COPY ./models/en.tar.gz ${RASA_NLU_HOME}
RUN pip install ${RASA_NLU_HOME}/en.tar.gz
RUN python -m spacy link en_model en
RUN rm en.tar.gz

RUN cp sample_configs/config_spacy_duckling.yml ${RASA_NLU_HOME}/config.yml

# Exposing resources
EXPOSE 5000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["start", "--path", "/app/projects", "-c", "config.yml", "--max_training_processes", "1"]
