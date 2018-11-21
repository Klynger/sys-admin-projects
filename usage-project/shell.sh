#!/bin/bash

while [ 1 ]; do
	
	echo -ne "[$(whoami)]@:$(pwd)$ "
	read entry
	
	if [ "$entry" == "exit" ] || [ -z $(which $entry) ]; then
	       exit
       	fi

	/usr/bin/time -f "%S\t%U" -o /tmp/usage-time $entry
	timeOutput=$(cat /tmp/usage-time)	
	logLine="`whoami`@`date +%y/%m/%d-%H:%M:%S`@$timeOutput@\"$entry\""
	echo $logLine >> log

done
