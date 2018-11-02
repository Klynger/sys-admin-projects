#!/bin/sh

filePath=$1

totalCharacters=$(wc $filePath -m | awk '{ print $1 }')

moduleOfDivision=$(expr $totalCharacters % 3600)

if (( $moduleOfDivision > 0 )); then
    totalPages=$(expr $totalCharacters / 3600 + 1)
else
    totalPages=$(expr $totalCharacters / 3600)
fi


echo $totalPages
