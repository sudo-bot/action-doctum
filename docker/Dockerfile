FROM php:cli-alpine

ARG RELEASE_VERSION=5

# Metadata params
ARG VCS_REF
ARG BUILD_DATE

COPY entrypoint.sh /entrypoint.sh

ADD https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar /bin/doctum

RUN echo "Downloaded release version: ${RELEASE_VERSION}" && chmod +x /bin/doctum && php /bin/doctum --version

# Metadata
LABEL org.label-schema.vendor="Sudo-Bot" \
    org.label-schema.url="https://github.com/sudo-bot/action-doctum#readme" \
    org.label-schema.name="Doctum action" \
    org.label-schema.description="Doctum action for GitHub actions" \
    org.label-schema.version=${RELEASE_VERSION} \
    org.label-schema.vcs-url="https://github.com/sudo-bot/action-doctum.git" \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.schema-version="1.0"

ENTRYPOINT ["/entrypoint.sh"]
