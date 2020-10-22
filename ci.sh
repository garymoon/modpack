#!/bin/bash -xeu

set -o pipefail

./update.sh
./build.sh
VERSION="$(git describe --tags --dirty=* --always)"
PROG="csprogs"
ARCHIVE="${PROG}-${VERSION}.pk3"
ARTIFACTS_ARCHIVE="smbmod-${VERSION}.zip"
PKGINFO="${PROG}-${VERSION}.txt"
echo "https://github.com/MarioSMB/modpack" > "${PKGINFO}"
mv ${PROG}{,-${VERSION}}.dat
mv ${PROG}{,-${VERSION}}.lno
zip -9 "${ARCHIVE}" ${PROG}-${VERSION}.{dat,lno} "${PKGINFO}" && mv "${ARCHIVE}" ~/deploy
zip -9 "${ARTIFACTS_ARCHIVE}" ./*.{dat,lno} "${PKGINFO}" && mv "${ARTIFACTS_ARCHIVE}" ~/deploy


