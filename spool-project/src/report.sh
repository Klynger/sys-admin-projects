yearOfReport=$1
monthOfReport=$2

quotaFilePath=$(grep "logs_file_path" .config | awk '{ print $2 }')
quotaFileName="$yearOfReport-$monthOfReport.txt"

fullPath="$quotaFilePath/$quotaFileName"

reportByUser=$(awk '{
count[$1] += $2
} {
  countFiles[$1] += 1
} END {
  for (i in count) {
    print i "   " count[i] "    " countFiles[i];
  }
}' $fullPath)

pagesPrinted=$(awk '{ x += $2 } END { print x }' $fullPath)
filesPrinted=$(wc -l $fullPath | awk '{ print $1 }')

echo -e "USER\tTOTAL PAGES PRINTED\tTOTAL FILES PRINTED"
echo "- $pagesPrinted $filesPrinted"
echo $reportByUser
