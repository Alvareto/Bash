#!/bin/bash

src=$1
dest=$2

if [ "$#" -ne 2 ]; then
	echo "Invalid argument count"
	echo ""
	echo "Type in source directory with images and destination directory."
	echo "For example: ./script.sh images images_by_month"
	echo ""
	exit -1
fi

for image in $(ls "$src")
do
	filename=$(basename "$image")
	extension="${filename##*.}"
	filename="${filename%.*}"
	if [ "$extension" != 'jpg' ]; then
		continue
	fi

	date=$(stat -c '%y' $src/$image | cut -d ' ' -f 1)
	year=$(echo	$date | cut -d '-' -f 1)
	month=$(echo $date | cut -d '-' -f 2)
	dateFolder=$year'-'$month

	destDateFolder=$dest/$dateFolder
	mkdir -p $destDateFolder
	mv $src/$image $destDateFolder
done