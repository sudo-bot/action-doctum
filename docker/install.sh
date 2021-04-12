#!/bin/sh

set -e

downloadFileIntoBin() {
    echo "::debug Downloading https://doctum.long-term.support/releases/${RELEASE_VERSION}/$1"
    curl -# -o "/bin/$1" "https://doctum.long-term.support/releases/${RELEASE_VERSION}/$1"
}

verifyRelease() {
    echo "::debug Checking the release"
    gpg --verify /bin/doctum.phar.asc /bin/doctum.phar
    gpg --verify /bin/doctum.phar.sha256.asc /bin/doctum.phar.sha256
    cd /bin/ > /dev/null && sha256sum -c -s -w /bin/doctum.phar.sha256 && cd - > /dev/null
}

cleanup() {
    rm /bin/doctum.phar.asc /bin/doctum.phar.sha256 /bin/doctum.phar.sha256.asc
    rm -rf /root/.gnupg
}

echo "::group::Downloading Doctum"

echo "::debug Release channel: ${RELEASE_VERSION}"

downloadFileIntoBin doctum.phar.sha256
downloadFileIntoBin doctum.phar.sha256.asc
downloadFileIntoBin doctum.phar.asc
downloadFileIntoBin doctum.phar
chmod +x /bin/doctum.phar

echo "::endgroup::"

echo "::group::Verify Doctum release"
verifyRelease
echo "::endgroup::"

mv /bin/doctum.phar /bin/doctum

if [ "${RELEASE_VERSION}" != "dev" ]; then
    echo "::debug Files cleanup"
    cleanup
fi

echo "::group::Doctum version metadata"
/bin/doctum version --text
echo "::endgroup::"
