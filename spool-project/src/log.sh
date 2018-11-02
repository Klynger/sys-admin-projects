#!/bin/sh

printedFilePath=$1
totalPagesPrinted=$2

loggedUser=$(whoami)
fileName="`date +%y-%m`.txt"
logFilePath=".logs/$fileName"

if [ ! -f $logFilePath ]; then
    touch $logFilePath
fi

currentTime=$(date +%y/%m/%d-%H:%M:%S)

echo "$loggedUser $totalPagesPrinted $currentTime $printedFilePath" >> $logFilePath
