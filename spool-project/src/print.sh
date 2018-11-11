#!/bin/bash

filePath=$1
totalPagesToPrint=$2

result=$(bash can-i-print.sh)

if [ "$result" = "You are not registered" -o "$result" = "You already printed all your quota for this month" ]
then
	echo "$result"
	exit 1

fi

documentPages=$(bash total-pages.sh $filePath)

if [ -z $totalPagesToPrint ]
then
	totalPagesToPrint=$documentPages 
fi

if [ $totalPagesToPrint -eq 0 ]
then
	echo "You need to print at least one page!"
	exit 1
fi

if [ $totalPagesToPrint -gt $documentPages ]
then
	echo "The number of pages selected to print is larger than the number of pages in the document, printing $documentPages pages"
	totalPagesToPrint=$documentPages
fi

currentPath=$(pwd)
usersFilePath=$(grep "users_file_path" "$currentPath/.config" | awk '{ print $2 }')

loggedUser=$(whoami)
leftPages=$(grep $loggedUser "$currentPath/$usersFilePath" | awk '{ print $2 }')

userLine="$loggedUser `expr $leftPages - $totalPagesToPrint`"
restOfFile=$(grep -Ev "^$loggedUser|^$" $usersFilePath)
echo "$restOfFile" > current-month.txt
echo "$userLine" >> current-month.txt

bash log.sh $filePath $totalPagesToPrint

echo "Printing $totalPagesToPrint of $documentPages pages of Document $filePath, User: $loggedUser"
