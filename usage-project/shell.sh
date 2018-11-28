#!/bin/bash

while [ 1 ]; do
	
	echo -ne "[$(whoami)]@:$(pwd)$ "
	read entry
	
	if [ "$entry" == "exit" ]; then
	       exit
       	fi
	
	echo $entry > /tmp/usage-time-command

	pureCommand=$(awk '{ print $1 }' /tmp/usage-time-command)
	if [ -z $(which $pureCommand) ]; then
		echo "You can't use this command here"
		exit 1
	fi

	/usr/bin/time -f "%S\t%U" -o /tmp/usage-time bash -c "$entry"
	timeOutput=$(cat /tmp/usage-time)	
	logLine="`whoami`@`date +%y/%m/%d-%H:%M:%S`@$timeOutput@\"$entry\""
	logPathName=".log/`date +%y-%m`"
	echo $logLine >> $logPathName
	echo $logLine >> log

done
