FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="Trino"
ARG TRINO_LINK="https://repo1.maven.org/maven2/io/trino/trino-server/403/trino-server-403.tar.gz"
ARG TRINO_ARC_VERSION="trino-server-403.tar.gz"
ARG TRINO_VERSION="trino-server-403"

ARG APP_TITLE="Trino CLI"
ARG TRINOCLI_LINK="https://repo1.maven.org/maven2/io/trino/trino-cli/403/trino-cli-403-executable.jar"
ARG TRINOCLI_JAR_VERSION="trino-cli-403-executable.jar"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
# ENV FOO="BAR"

#EXPOSE 8080
#EXPOSE 8181
#EXPOSE 9080
#EXPOSE 9081

# Switch to non-root user
USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
