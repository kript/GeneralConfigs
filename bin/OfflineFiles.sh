#!/bin/bash
#script to ensure my home server has a replica of my laptop file

#check we can reach the server, quit if not
ping -c1 -q  freenas.lab.kript.net > /dev/null #we don't actually want the output
if  [ $? -ne 0 ]
then
#	echo "Can't reach NAS box"
	exit 1;
else
	#rsync Documents
#	 rsync -avz ~/Documents/ john@192.168.1.50:/mnt/fs1/home/john/Documents/ --filter="- ISOs" --filter="- Virtual*"
#	if  [ $? -ne 0 ] then exit 1 fi
	#rsync Music
	rsync -avz ~/Music/ john@192.168.1.50:/mnt/fs1/music/;
	if  [ $? -ne 0 ] 
	then 
		exit 1 
	fi
	#rsync Pictures
	rsync -avz ~/Pictures/ john@192.168.1.50:/mnt/fs1/home/john/Pictures/	
	if  [ $? -ne 0 ] 
	then 
		exit 1 
	fi
	#rsync Documents 
	rsync -avz ~/Documents/ john@192.168.1.50:/mnt/fs1/home/john/Documents/ --filter="- ISOs" --filter="- Virtual*"

	if  [ $? -ne 0 ] 
	then 
		exit 1 
	fi

fi
	exit 0

