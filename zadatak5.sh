#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "***********"
	echo "Invalid argument count"
	echo ""
	echo "Type in directory name and name pattern to look for. For ex."
	echo "./script.sh myDirectory *.c"
	echo "***********"
	exit 1
fi

directory=$1
pattern=$2

echo $directory
echo $pattern

lineCount=0
for file in $(find $directory -name "$pattern"); do
	fileLineCount=$(wc -l $file | cut -d ' ' -f 1)
	echo $fileLineCount" "$file
	lineCount=$(($lineCount+$fileLineCount))
done

echo "Total lines: "$lineCount