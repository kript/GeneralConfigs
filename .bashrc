source ~/perl5/perlbrew/etc/bashrc

# append to the history file, don't overwrite it
mkdir -p ~/.history
shopt -s histappend
shopt -s cmdhist

export HISTFILE=~/.history/`date +%Y-%m-%d`.hist
PROMPT_COMMAND="history -n;history -a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
#disabled for a sanger enviornment and the stat calls make this a nightmare on are larger NFS shares..

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
unset color_prompt force_color_prompt

perlbrew use perl-5.12.4
