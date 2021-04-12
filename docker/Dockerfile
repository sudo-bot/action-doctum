FROM alpine:3.13

ARG RELEASE_VERSION=5

# Metadata params
ARG VCS_REF
ARG BUILD_DATE

COPY entrypoint.sh /entrypoint.sh

RUN set -ex; \
    echo 'Installing PHP'; \
    apk add --no-cache --update php8-cli php8-phar git; \
    apk add --no-cache --update --virtual .build-deps curl gnupg; \
    echo 'Adding GPG key'; \
    curl -s -o /tmp/public-key.asc https://williamdes.eu/public-key.asc; \
    gpg --import /tmp/public-key.asc; \
    LC_ALL=C.UTF-8 gpg --keyid-format long --import --with-fingerprint --import-options show-only /tmp/public-key.asc \
        | grep -F "Key fingerprint = C4D9 1FDF CEF6 B4A3 C653  FD78 90A0 EF1B 8251 A889"; \
    echo "Downloaded release channel: ${RELEASE_VERSION}"; \
    curl -# -o /bin/doctum.phar.sha256 https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar.sha256; \
    curl -# -o /bin/doctum.phar.sha256.asc https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar.sha256.asc; \
    curl -# -o /bin/doctum.phar.asc https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar.asc; \
    curl -# -o /bin/doctum.phar https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar; \
    gpg --verify /bin/doctum.phar.asc /bin/doctum.phar; \
    gpg --verify /bin/doctum.phar.sha256.asc /bin/doctum.phar.sha256; \
    cd /bin/ > /dev/null && sha256sum -c -s -w /bin/doctum.phar.sha256 && cd - > /dev/null; \
    rm /tmp/public-key.asc /bin/doctum.phar.asc /bin/doctum.phar.sha256 /bin/doctum.phar.sha256.asc; \
    rm -rf /root/.gnupg; \
    apk del .build-deps; \
    ln -s /usr/bin/php8 /bin/php; \
    mv /bin/doctum.phar /bin/doctum; \
    chmod +x /bin/doctum; \
    /bin/php --version; \
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
