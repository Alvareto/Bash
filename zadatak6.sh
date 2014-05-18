#!/bin/bash

if [ "$#" -lt 2 ]; then #if number of arguments is less than two
	echo "***********"
	echo "Invalid argument count"
	echo ""
	echo "Type in at least one file name and destination backup directory. For ex."
	echo "./script.sh myFile.txt backup"
	echo "***********"
	exit 1
fi

paramsCount=$#
dest=$(eval "echo \${$paramsCount}")
if [ ! -d $dest ]; then
	echo "Created destination directory "$dest
	mkdir -p $dest
fi
č
filesCopied=0
for parameterNumber in $(eval echo {1..$(($paramsCount-1))})
do
	parameterValue=$(eval "echo \${$parameterNumber}")
	# if it's destination backup directory, continue
	if [ $parameterValue = $dest]; then
		continue
	fi
	elif [ ! -f $parameterValue -a ! -d $parameterValue ]; then
		echo $parameterValue" doesn't exist"
		continue
	fi

	accessFlags=$(stat -c "%A" $parameterValue) # %A access rights in human readable form
	readableFlag=$(echo $accessFlags | head -c 2 | tail -c 1)
	if [ $readableFlag = "r" ]; then
		filesCopied=$(($filesCopied+1))
		cp -r $parameterValue $dest
	else
		echo $parameterValue" is not readable"
	fi
done

echo "Successfully copied "$filesCopied" files."