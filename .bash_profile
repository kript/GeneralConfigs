http_proxy=wwwcache.sanger.ac.uk:3128
export http_proxy
https_proxy=wwwcache.sanger.ac.uk:3128
export https_proxy

source ~/perl5/perlbrew/etc/bashrc

# MacPorts Installer addition on 2011-07-08_at_15:31:36: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Finished adapting your PATH environment variable for use with MacPorts.

#add path for ~/Applications directory
export PATH=/Users/jc18/Applications:$PATH

#add path for ~/Applications directory
export PATH=/Users/jc18/bin:$PATH

# append to the history file, don't overwrite it
mkdir -p ~/.history
shopt -s histappend
shopt -s cmdhist

export HISTFILE=~/.history/`date +%Y-%m-%d`.hist
PROMPT_COMMAND="history -n;history -a"

