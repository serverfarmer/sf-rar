#!/bin/sh

curl -sS https://www.rarlab.com |grep "WinRAR and RAR .... release" |egrep -o '[0-9]{1}\.[0-9]{1,3}' |sed -e s/[.]//g -e 's/./&./g' -e s/[.]$//g
