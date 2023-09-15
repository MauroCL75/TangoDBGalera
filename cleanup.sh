#!/bin/sh
here=`pwd`
here="$here/storage"
dirs="1 2 3 4"

for i in $dirs; do
	sudo rm -fr $here/$i
	sudo mkdir -p $here/$i
	sudo chmod 777 $here/$i
done
