#!/bin/bash

filePath=$1
totalPagesToPrint=$2

result=$(bash can-i-print.sh)

if [ "$result" = "You are not registered" -o "$result" = "You already printed all your quota for this month" -o "$result" = "You can't print anything this month" ]
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

quotaFilePath=$(grep "quota_file_path" .config | awk '{ print $2 }')
quotaFileName="`date +%y-%m`.txt"

loggedUser=$(whoami)
leftPages=$(grep $loggedUser $quotaFilePath/$quotaFileName | awk '{ print $2 }')
userLine="$loggedUser `expr $leftPages - $totalPagesToPrint`"
restOfFile=$(grep -Ev "^$loggedUser|^$" $quotaFilePath/$quotaFileName)
echo "$restOfFile" > $quotaFilePath/$quotaFileName
echo "$userLine" >> $quotaFilePath/$quotaFileName

bash log.sh $filePath $totalPagesToPrint

echo "Printing $totalPagesToPrint of $documentPages pages of Document $filePath, User: $loggedUser"
# Here would be the place where the lp command would be used, soon after to validate the user's print request.
