#!/bin/bash -xeu

set -o pipefail

./update.sh
./build.sh
VERSION="$(git describe --tags --dirty=* --always)"
if [[ -v GITHUB_ENV ]]; then
  echo "VERSION=$VERSION" >> "$GITHUB_ENV"
fi
PROG="csprogs"
ARCHIVE="${PROG}-${VERSION}.pk3"
ARTIFACTS_ARCHIVE="smbmod-${VERSION}.zip"
PKGINFO="${PROG}-${VERSION}.txt"
echo "https://github.com/MarioSMB/modpack" > "${PKGINFO}"
zip -9 "${ARTIFACTS_ARCHIVE}" ./*.{dat,lno} "${PKGINFO}"
cp ${PROG}{,-${VERSION}}.dat
cp ${PROG}{,-${VERSION}}.lno
zip -9 "${ARCHIVE}" ${PROG}-${VERSION}.{dat,lno} "${PKGINFO}"
