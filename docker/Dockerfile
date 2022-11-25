FROM alpine:3.17

ARG RELEASE_VERSION=latest

# Metadata params
ARG VCS_REF
ARG BUILD_DATE

COPY entrypoint.sh /entrypoint.sh
COPY install.sh /install.sh

RUN set -ex; \
    echo 'Installing PHP'; \
    apk add --no-cache --update php81-cli php81-phar php81-tokenizer php81-iconv php81-mbstring git su-exec; \
    apk add --no-cache --update --virtual .build-deps curl gnupg; \
    ln -s /usr/bin/php81 /bin/php; \
    echo 'Adding GPG key'; \
    mkdir -p /doctum/.gnupg; \
    curl -s -o /doctum/public-key.asc https://williamdes.eu/public-key.asc; \
    LC_ALL=C.UTF-8 gpg --keyid-format long --import --with-fingerprint --import-options show-only /doctum/public-key.asc \
        | grep -F "Key fingerprint = C4D9 1FDF CEF6 B4A3 C653  FD78 90A0 EF1B 8251 A889"; \
    LC_ALL=C.UTF-8 gpg --homedir /doctum/.gnupg --import /doctum/public-key.asc; \
    rm /doctum/public-key.asc; \
    echo 'C4D91FDFCEF6B4A3C653FD7890A0EF1B8251A889:6' | gpg --homedir /doctum/.gnupg --import-ownertrust; \
    chmod 777 -R /doctum /entrypoint.sh /install.sh; \
    gpg --homedir /doctum/.gnupg --list-keys; \
    echo 'Installing Doctum'; \
    /install.sh; \
    echo 'Cleanup and tests'; \
    if [ "${RELEASE_VERSION}" != "dev" ]; then apk del .build-deps; fi; \
    if [ "${RELEASE_VERSION}" = "dev" ]; then curl --version; fi; \
    /bin/php --version; \
    git --version; \
    /bin/doctum version --text

# Metadata
LABEL org.label-schema.vendor="Sudo-Bot" \
    org.label-schema.url="https://github.com/sudo-bot/action-doctum#readme" \
    org.label-schema.name="Doctum GitHub action" \
    org.label-schema.description="Doctum action for GitHub actions" \
    org.label-schema.version=${RELEASE_VERSION} \
    org.label-schema.vcs-url="https://github.com/sudo-bot/action-doctum.git" \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.schema-version="1.0" \
    \
    com.docker.extension.publisher-url="https://github.com/wdes" \
    \
    org.opencontainers.image.title="Doctum GitHub action" \
    org.opencontainers.image.description="Doctum action for GitHub actions" \
    org.opencontainers.image.authors="williamdes@wdes.fr" \
    org.opencontainers.image.url="https://github.com/sudo-bot/action-doctum#readme" \
    org.opencontainers.image.documentation="https://github.com/sudo-bot/action-doctum#readme" \
    org.opencontainers.image.source="https://github.com/sudo-bot/action-doctum" \
    org.opencontainers.image.vendor="Sudo-Bot" \
    org.opencontainers.image.licenses="MPL-2.0" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${RELEASE_VERSION} \
    org.opencontainers.image.revision=${VCS_REF} \
    org.opencontainers.image.ref.name="latest"

ENTRYPOINT ["/entrypoint.sh"]
