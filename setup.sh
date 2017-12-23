#!/bin/sh
. /opt/farm/scripts/init


# TODO: discover the latest available RAR version automatically (currently hardcoded)
# http://rarlab.com/download.htm
VERSION="5.5.0"


if [ "$OSTYPE" = "freebsd" ]; then
	FILE="rarbsd-$VERSION.tar.gz"
elif [ "`uname`" != "Linux" ]; then
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
if [ "$OSVER" = "freebsd-9" ]; then
    mv -f rar_static rar
fi
make
cd "$DIR"
