
# MacPorts Installer addition on 2011-07-08_at_15:31:36: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#add path for ~/Applications directory
export PATH=/Users/jc18/Applications:$PATH

#perlbrew
source ~/perl5/perlbrew/etc/bashrc

http_proxy=wwwcache.sanger.ac.uk:3128
export http_proxy
https_proxy=wwwcache.sanger.ac.uk:3128
export https_proxy





#add path for ~/Applications directory
export PATH=/Users/jc18/bin:$PATH

#alias for getting the HBA info from a system
alias Get-HBA-Info='systool -c fc_host -A port_name'

#aide memoir for flushing the DNS cahce
alias flushcache='sudo killall -HUP mDNSResponder'

#nify nmap-alike entirely in bash
# from http://www.catonmat.net/blog/tcp-port-scanner-in-bash/
alarm() {
  perl -e '
    eval {
      $SIG{ALRM} = sub { die };
      alarm shift;
      system(@ARGV);
    };
    if ($@) { exit 1 }
  ' "$@";
}

scan() {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    return
  fi

  local host=$1
  local ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac


  for port in "${ports[@]}"; do
    alarm 1 "echo >/dev/tcp/$host/$port &&
      echo \"port $port is open\"" ||
      echo "port $port is closed"
  done
}

#why MacOSX Doesn't do this I have no idea
source ~/.bashrc
