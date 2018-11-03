#!/bin/sh

filePath=$1
totalPagesToPrint=$2

# bash can-i-print.sh
currentPath=$(pwd)
usersFilePath=$(grep "users_file_path" $currentPath/.config | awk '{ print $2 }')

loggedUser=$(whoami)
leftPages=$(grep $loggedUser $currentPath/$usersFilePath | awk '{ print $2 }')

userLine="$loggedUser `expr $leftPages - $totalPagesToPrint`"
restOfFile=$(grep -Ev "^$loggedUser|^$" $usersFilePath)
echo "$restOfFile" > current-month.txt
echo "$userLine" >> current-month.txt

bash log.sh $filePath $totalPagesToPrint

# totalPages=$(bash total-pages.sh $filePath)
