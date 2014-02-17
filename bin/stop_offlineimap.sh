#/bin/bash
# script to kick offlineimap to get it to istop autorefresh and abort after current check - i.e. shutdown

offlineimap_pid=`ps auxww | grep offline | grep -v grep | awk '{print $2}'`
kill -s SIGUSR2 $offlineimap_pid 
