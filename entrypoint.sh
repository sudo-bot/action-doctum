#!/bin/sh -l
##
# @license http://unlicense.org/UNLICENSE The UNLICENSE
# @author William Desportes <williamdes@wdes.fr>
##

set -e

CONFIG_FILE="$1"
METHOD="$2"
CLI_ARGS="$3"

echo "::debug CONFIG_FILE: ${CONFIG_FILE}"
echo "::debug METHOD: ${METHOD}"
echo "::debug CLI_ARGS: ${CLI_ARGS}"

php /bin/doctum ${METHOD} ${CLI_ARGS} ${CONFIG_FILE}
