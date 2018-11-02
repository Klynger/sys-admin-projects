#!/bin/sh

filePath=$1
totalPagesToPrint=$2

loggedUser=$(whoami)
leftPages=$(grep $loggedUser current-month.txt | awk '{ print $2 }')
userLine="$loggedUser `expr $leftPages - $totalPagesToPrint`"
restOfFile=$(grep -Ev "^$loggedUser|^$" current-month.txt)
echo "$restOfFile" > current-month.txt
echo "$userLine" >> current-month.txt

bash log.sh $filePath $totalPagesToPrint

# totalPages=$(bash total-pages.sh $filePath)
