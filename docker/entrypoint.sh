#!/bin/sh -l
##
# @license http://unlicense.org/UNLICENSE The UNLICENSE
# @author William Desportes <williamdes@wdes.fr>
##

set -e

RELEASE_VERSION="$1"
CONFIG_FILE="$2"
METHOD="$3"
CLI_ARGS="$4"

echo "::debug RELEASE_VERSION: ${RELEASE_VERSION}"
echo "::debug CONFIG_FILE: ${CONFIG_FILE}"
echo "::debug METHOD: ${METHOD}"
echo "::debug CLI_ARGS: ${CLI_ARGS}"

if [ ! -f /bin/doctum ] || [ ${RELEASE_VERSION} = "dev" ]; then
    echo "::group::Downloading Doctum"
    echo "::debug Downloading https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar"
    curl -# -o /bin/doctum https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar
    chmod +x /bin/doctum
    echo "::debug Downloading https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar.sha256"
    curl -# -o /bin/doctum.sha256 https://doctum.long-term.support/releases/${RELEASE_VERSION}/doctum.phar.sha256
    cd /bin/
    echo "::debug Checking the file"
    sed -i 's/doctum.phar/doctum/' /bin/doctum.sha256
    sha256sum --status --check --strict /bin/doctum.sha256
    cd - > /dev/null
    echo "::endgroup::"
fi

php /bin/doctum ${METHOD} ${CLI_ARGS} ${CONFIG_FILE} 2>&1
