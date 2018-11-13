monthQuota=$1
userPath="/home/$(whoami)"

cp -R ../spool-project $userPath

projectPath="$userPath/spool-project/src"
configPath="$projectPath/.config"

touch "$configPath"

echo "max_quota $monthQuota" >> "$configPath"
echo "users_file_name users.txt" >> "$configPath"
echo "quota_file_path .quota" >> "$configPath"
echo "logs_file_path .logs" >> $configPath

mkdir "$projectPath/.quota"
mkdir "$projectPath/.logs"

touch "$projectPath/users.txt"

