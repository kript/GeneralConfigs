#/bin/bash
# script to kick offlineimap to get it to check for mail

offlineimap_pid=`ps auxww | grep offline | grep -v grep | awk '{print $2}'`
kill -s SIGUSR1 $offlineimap_pid 
