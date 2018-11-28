yearOfReport=$1
monthOfReport=$2
user=$3

logFilePath=".log/$yearOfReport-$monthOfReport"
totalSystemUsageTime=$(awk -F@ '{
    print $3
}' $logFilePath | awk '{
    systemUsage += $1
} END { print systemUsage }')

totalUserUsageTime=$(awk -F@ '{
    print $3
}' $logFilePath | awk '{
    userUsage += $2;
} END { print userUsage }')

echo "USAGE IN SYSTEM MODE $totalSystemUsageTime segs"
echo "USAGE IN USER MODE $totalUserUsageTime segs"
echo "---------------------------------------------"

echo -e "COUNT\tCOMMAND"
awk -F@ '{
    print $4
}' $logFilePath | awk '{
    printf "%s\n", $1
}' | awk -F\" '{ print $2 }' | sort | uniq -c | awk '{
    print $1 "\t" $2
}'
