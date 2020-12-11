FROM php:cli-alpine

ARG RELEASE_VERSION=latest

COPY entrypoint.sh /entrypoint.sh

ADD https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar /bin/doctum

RUN echo "Downloaded release version: ${RELEASE_VERSION}" && chmod +x /bin/doctum && php /bin/doctum --version

ENTRYPOINT ["/entrypoint.sh"]
