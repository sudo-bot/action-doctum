#!/bin/sh -l
##
# @license http://unlicense.org/UNLICENSE The UNLICENSE
# @author William Desportes <williamdes@wdes.fr>
##

set -e

trim() {
    trimmed="$1"

    # Strip leading space.
    trimmed="${trimmed## }"
    # Strip trailing space.
    trimmed="${trimmed%% }"

    echo "$trimmed"
}

RELEASE_VERSION="$(trim "$1")"
CONFIG_FILE="$2"
METHOD="$3"
CLI_ARGS="$4"

echo "::debug RELEASE_VERSION: ${RELEASE_VERSION}"
echo "::debug CONFIG_FILE: ${CONFIG_FILE}"
echo "::debug METHOD: ${METHOD}"
echo "::debug CLI_ARGS: ${CLI_ARGS}"

if [ ! -f /bin/doctum ] || [ "${RELEASE_VERSION}" = "dev" ]; then
    RELEASE_VERSION="${RELEASE_VERSION}" /install.sh
fi

php -d memory_limit=-1 /bin/doctum ${METHOD} ${CLI_ARGS} ${CONFIG_FILE} 2>&1
