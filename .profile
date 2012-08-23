
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

#why MacOSX Doesn't do this I have no idea
source ~/.bashrc
