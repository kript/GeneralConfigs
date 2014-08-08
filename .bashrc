source ~/perl5/perlbrew/etc/bashrc

#add path for local homebrew directory
export PATH=/Users/jc18/homebrew/bin:$PATH
#add path for ~/Applications directory
export PATH=/Users/jc18/Applications:$PATH
#add path for ~/bin directory
export PATH=/Users/jc18/bin:$PATH
#add path for local python modules
#export PATH=/Users/jc18/Library/Python/2.7/bin/:$PATH

#PROMPT_COMMAND="history -n;history -a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#perlbrew use perl-5.12.4

#switch to using Joe's proxy variant
#only enable the proxies if we're on internal LAN
#SangerWireless="(WTSI Wireless)"
#SangerWired="(Sanger Wired)"
#wirelessLAN=`scselect | grep " \*" | cut -f2`
#
#if [ "$wirelessLAN" == "$SangerWireless" ]
#	then
#		echo "enabling proxies"
#		http_proxy=wwwcache.sanger.ac.uk:3128
#		export http_proxy
#		https_proxy=wwwcache.sanger.ac.uk:3128
#		export https_proxy
#	else
#		echo "disabling proxies"
#fi

#===Start===

proxy_on()
        {
        echo "enabling proxies"
        http_proxy=wwwcache.sanger.ac.uk:3128
        export http_proxy
        https_proxy=wwwcache.sanger.ac.uk:3128
        export https_proxy
        export no_proxy=sanger.ac.uk
        }

proxy_off()
        {
        echo "disabling proxies"
        unset http_proxy
        unset https_proxy
        }


#only enable the proxies if we're on internal LAN/VPN
if ping -c 1 wwwcache.sanger.ac.uk &> /dev/null
then
        proxy_on
else
        proxy_off
fi


#===FIN===


alias mutt='title "Mutt"; cd ~/Downloads && mutt'
alias offlineimap='title "OfflineIMAP"; offlineimap'
alias dnsgrep='ssh it-admin dig -t axfr internal.sanger.ac.uk | grep $2'
alias irods_test='csshX -screen 2 -l root isg-dev4 isg-dev5'
