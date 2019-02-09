#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cless='less -R'

#PS1='[\u@\h \W]\$ '
export PS1="\[\e[0m\]\[\e[00;35m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]\[\033[0m\]>\n$ \[\e[0m\]"

ask_confirm()
{
    local user_decision=""

    echo $1
    read -p "contiune[yes/no]? " user_decision

    while [ "yes" != "${user_decision}" -a "no" != "${user_decision}" ]
    do
        read -p "contiune[yes/no]?, please answer 'yes' or 'no': " user_decision
    done

    [ "yes" == "${user_decision}" ] && return 0
    return 1
}

alternate()
{
    if [ ! -f $2 ]; then
        echo "$2 is not exist"
        return 0
    fi

    if [ ! -e $1 ]; then
        sudo ln -s $2 $1
        return 1
    fi

    if [ -h $1 ]; then
        ask_confirm "Replacing $1 by $2 ?"
        if [ "$?" == "1" ]; then
            return 0
        fi
        sudo rm $1
        sudo ln -s $2 $1
    else
        echo "WARNING: $1 is not a symbolic link"
        ask_confirm "Replacing $1 by $2 ?"
        if [ "$?" == "1" ]; then
            return 0
        fi
        sudo rm $1
        sudo ln -s $2 $1
    fi
}

#This is for using GUI in sudo mode
export XAUTHORITY=~/.Xauthority

