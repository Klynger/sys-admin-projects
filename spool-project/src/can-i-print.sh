usersFilePath=$(grep "users_file_path" .config | awk '{ print $2 }')
loggedUser=$(whoami)
result=$(awk '{ if (NR!=1) print $1 }' $usersFilePath | grep $loggedUser)

if [ "$result" != "$loggedUser" ]
then
    echo "You are not registered"
    exit 1
fi

leftToPrint=$(grep "$loggedUser" $usersFilePath | awk '{ print $2 }')

if [ $leftToPrint -le 0 ]
then
    echo "You already printed all your quota for this month"
    exit 1
fi

echo $result
