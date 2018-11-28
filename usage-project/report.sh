yearOfReport=$1
monthOfReport=$2
user=$3

logFilePath=".log/$yearOfReport-$monthOfReport"
totalUsageTime=$(awk -F@ '{
    print $3
}' $logFilePath | awk '{
    systemUsage += $1;
    userUsage += $2;
} END { printf "%ss\t%ss", systemUsage, userUsage }')

echo -e "USAGE IN SYSTEM MODE\tUSAGE IN USER MODE"
echo $totalUsageTime
echo "---------------------------------------------"

echo -e "COUNT\tCOMMAND"
awk -F@ '{
    print $4
}' $logFilePath | awk '{
    printf "%s\n", $1
}' | awk -F\" '{ print $2 }' | sort | uniq -c
