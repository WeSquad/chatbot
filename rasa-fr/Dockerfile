FROM rasa-base:latest

ENV RASA_NLU_HOME=/app \
    RASA_NLU_PYTHON_PACKAGES=/usr/local/lib/python2.7/dist-packages

WORKDIR ${RASA_NLU_HOME}

# Installing FR lang package
COPY ./models/fr.tar.gz ${RASA_NLU_HOME}
RUN pip install ${RASA_NLU_HOME}/fr.tar.gz
RUN python -m spacy link fr_model fr
RUN rm fr.tar.gz


# Exposing resources
EXPOSE 5000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["start", "--path", "/app/projects", "-c", "config.yml", "--max_training_processes", "1"]
