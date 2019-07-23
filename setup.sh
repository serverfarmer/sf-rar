#!/bin/sh
. /opt/farm/scripts/init

/opt/farm/ext/packages/utils/install.sh make wget curl

VERSION=`/opt/farm/ext/rar/get-rar-version.sh`

if [ "$VERSION" = "" ]; then
	echo "skipping rar setup, unable to detect current version"
	exit 0
elif [ "$OSTYPE" = "freebsd" ]; then
	FILE="rarbsd-$VERSION.tar.gz"
elif [ "$HWTYPE" = "oem" ] || [ "`uname`" != "Linux" ]; then
	echo "skipping rar setup, unsupported system"
	exit 0
elif [ "`uname -m`" = "x86_64" ]; then
	FILE="rarlinux-x64-$VERSION.tar.gz"
else
	FILE="rarlinux-$VERSION.tar.gz"
fi

rm -rf /tmp/rar /tmp/$FILE

DIR="`pwd`"
cd /tmp
wget "https://rarlab.com/rar/$FILE"
tar xzf $FILE
rm -f $FILE
cd rar
if [ "$OSVER" = "freebsd-9" ] && [ -f rar_static ]; then
    mv -f rar_static rar
fi
make
cd "$DIR"
