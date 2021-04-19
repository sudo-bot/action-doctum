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

createUser() {
    if [ "${USER_ID}" != "0" ]; then
        echo "::debug Detected user-id: ${USER_ID}"
        echo "::debug Detected group-id: ${GROUP_ID}"
        addgroup -g "${GROUP_ID}" doctum
        adduser -h "${PWD}" -D -u "${USER_ID}" -G doctum -s "${SHELL}" doctum
        echo "::debug User created: $(id doctum)"
        echo "::debug Exec as $(su-exec doctum id -n -u): \"$(id)\", home: ${PWD}"
    else
        echo "::debug The user is root, skipping"
    fi
}

RELEASE_VERSION="$(trim "$1")"
CONFIG_FILE="$2"
METHOD="$3"
CLI_ARGS="$4"

echo "::group:: Init phase before Doctum run"
echo "::debug RELEASE_VERSION: ${RELEASE_VERSION}"
echo "::debug CONFIG_FILE: ${CONFIG_FILE}"
echo "::debug METHOD: ${METHOD}"
echo "::debug CLI_ARGS: ${CLI_ARGS}"
echo "::debug USER_ID: ${USER_ID}"
echo "::debug GROUP_ID: ${GROUP_ID}"

# If ENVs are empty and the config is a file and SKIP_OWNER_SWITCH is not defined
if [ -z "${USER_ID}" ] && [ -z "${GROUP_ID}" ] && [ -f "${CONFIG_FILE}" ] && [ -z "${SKIP_OWNER_SWITCH}" ]; then
    # User must be root
    if [ "$(id -u)" = "0" ]; then
        echo "::debug No user detected, creating one from the config file owner and group"
        USER_ID="$(stat -c "%u" "${CONFIG_FILE}")"
        GROUP_ID="$(stat -c "%g" "${CONFIG_FILE}")"
        createUser
    else
        USER_ID="$(id -u)"
        GROUP_ID="$(id -g)"
    fi
# If ENVs are NOT empty and SKIP_OWNER_SWITCH is not defined
elif [ -n "${USER_ID}" ] && [ -n "${GROUP_ID}" ] && [ -z "${SKIP_OWNER_SWITCH}" ]; then
    # User must be root
    if [ "$(id -u)" = "0" ]; then
        createUser
    else
        USER_ID="$(id -u)"
        GROUP_ID="$(id -g)"
    fi
fi
echo "::endgroup::"

if [ ! -f /bin/doctum ] || [ "${RELEASE_VERSION}" = "dev" ]; then
    RELEASE_VERSION="${RELEASE_VERSION}" /install.sh
fi

su-exec "${USER_ID}:${GROUP_ID}" php -d memory_limit=-1 /bin/doctum ${METHOD} ${CLI_ARGS} ${CONFIG_FILE} 2>&1
