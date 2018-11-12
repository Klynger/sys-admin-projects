#!/bin/bash

loggedUser=$(whoami)
usersFileName=$(grep "users_file_name" .config | awk '{ print $2 }')
result=$(grep $loggedUser $usersFileName)

if [ "$result" != "$loggedUser" ]
then
    echo "You are not registered"
    exit 1
fi


quotaFilePath=$(grep "quota_file_path" .config | awk '{ print $2 }')
quotaFileName="`date +%y-%m`.txt"
touch $quotaFilePath/$quotaFileName

maxQuota=$(grep "max_quota" .config | awk '{ print $2 }')
leftToPrint=$(grep "$loggedUser" $quotaFilePath/$quotaFileName | awk '{ print $2 }')
loggedUserHasHistory=$(grep "$loggedUser" $quotaFilePath/$quotaFileName)
if [ -z "$loggedUserHasHistory" ]
then
    curMonth=$(date +%m)
    prevMonth=$(expr `expr $curMonth + 11` % 12)
    quotaFileNamePrevMonth="`date +%y-`$prevMonth.txt"
    touch $quotaFilePath/$quotaFileNamePrevMonth

    printedLastMonth=$(grep "$loggeduser" $quotaFilePath/$quotaFileNamePrevMonth | awk '{ print $2 }')


    if [ -z $printedLastMonth ]
    then
        userLine="$loggedUser $maxQuota"
        echo "$userLine" >> $quotaFilePath/$quotaFileName
        exit 0
    fi
    
    
    if [ $(expr $maxQuota + $printedLastMonth) -lt 0 ]
    then
        echo "You can't print anything this month"
        exit 1
    elif [ $printedLastMonth -lt 0 ]
    then
        userLine="$loggedUser `expr $maxQuota + $printedLastMonth`"
        echo "$userLine" >> $quotaFilePath/$quotaFileName
    else
        userLine="$loggedUser $maxQuota"
        echo "$userLine" >> $quotaFilePath/$quotaFileName
        exit 0
    fi

elif [ $leftToPrint -lt 0 ]
then
    echo "You already printed all your quota for this month"
    exit 1
fi
