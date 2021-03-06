FROM alpine:3.13

ARG RELEASE_VERSION=latest

# Metadata params
ARG VCS_REF
ARG BUILD_DATE

COPY entrypoint.sh /entrypoint.sh
COPY install.sh /install.sh

RUN set -ex; \
    echo 'Installing PHP'; \
    apk add --no-cache --update php8-cli php8-phar php8-tokenizer php8-iconv php8-mbstring git su-exec; \
    apk add --no-cache --update --virtual .build-deps curl gnupg; \
    ln -s /usr/bin/php8 /bin/php; \
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
    org.label-schema.name="Doctum action" \
    org.label-schema.description="Doctum action for GitHub actions" \
    org.label-schema.version=${RELEASE_VERSION} \
    org.label-schema.vcs-url="https://github.com/sudo-bot/action-doctum.git" \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.schema-version="1.0"

ENTRYPOINT ["/entrypoint.sh"]
