#zsh config file by nému & nico

#export NAME='NOM Prenom'
#export FULLNAME='NOM Prenom'
export EMAIL="$USER@yaka.epita.fr"
export REPLYTO=$EMAIL

export CC=gcc
export CVS_RSH="ssh"
export EDITOR="emacs"
export HISTFILE=~/.zsh_history
export HISTSIZE=4096
export LANG=en_US.UTF-8
export MALLOC_CHECK_=3
export NNTPSERVER='news.epita.fr'
export SAVEHIST=4096
[ "$USER" = "root" ] && export TMOUT=600

if command most 2> /dev/null
then
    export PAGER="most"
elif command less 2> /dev/null
then
    export PAGER="less"
fi

export LESSCHARSET="utf-8"
export LESS_TERMCAP_mb=$(printf "\e[1;37m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

setopt appendhistory nomatch
setopt extended_glob
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt sh_word_split # Do not quote expanded vars
unsetopt beep notify

which gnuls > /dev/null && alias ls='gnuls --color=auto -F -h' ||
alias ls='ls --color=auto -F -h'
alias ll='ls -l'
alias l='ll'
alias la='ls -la'
alias lla='ls -la'
alias emacs='emacs -nw'
alias ne='emacs'
alias e='emacs'
alias df='df -h'
alias reload="source ~/.zshrc"

autoload -U colors && colors

zstyle ':completion:*:default' list-colors ''

MD5CMD=`(which md5sum > /dev/null && echo "md5sum") ||
(which md5 > /dev/null && echo "md5") || echo "cat"`

case `echo $(hostname) | $MD5CMD | sed -E 's/^(.).*$/\1/'` in
    "b"|"6")
	HOST_COLOR="red" ;;
    "1"|"8"|"7")
	HOST_COLOR="magenta" ;;
    "5"|"4"|"a")
	HOST_COLOR="yellow" ;;
    "2"|"9"|"d")
	HOST_COLOR="blue" ;;
    "f"|"c"|"e")
	HOST_COLOR="cyan" ;;
    "3"|"0"|"f")
	HOST_COLOR="green" ;;
    *)
	HOST_COLOR="white" ;;
esac

PROMPT="%(!.%F{red}%B.%F{white})%n@%F{${HOST_COLOR}}%m%(!.%b.)%f:%F{cyan}%~%f%(?.%F{green}.%B%F{red})%#%f%b "
RPROMPT='%F{blue}%T%f %(?.%F{green}.%F{red}%B)%?%f'
setopt nopromptcr

export CLICOLOR="YES"
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
which dircolors > /dev/null && eval `dircolors`

# Fix keyboard
bindkey -e
bindkey '^W' vi-backward-kill-word
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '[D' emacs-backward-word
bindkey '[C' emacs-forward-word

for confFiles in ~/.myzsh ~/.zshrc.local ~/.zshrc_functions; do
    [ -r "$confFiles" ] && source "$confFiles"
done

autoload -U compinit && compinit

# clone assistant repo
clone() {
    test $# -eq 1 || {
        echo "Usage: $0 PROJNAME" >&2
        return 1
    }
    ( which hg > /dev/null || echo "hg command not found" ) && (
    echo "Cloning $1 ..."
    hg clone "https://forge.acu.epita.fr/projects/$1" )
}

# clone student repo
clone_git() {
    test $# -eq 3 || {
	echo "Usage: $0 YEAR PROJNAME LOGIN" >&2
	echo "PROJNAME as seen by the intranet, not the name your HG repo" >&2
	return 1
    }
    ( which git > /dev/null || echo "git command not found" ) && (
    echo "Cloning repository for $3, project $1-$2 ..."
    git clone "ssh://git@git.acu.epita.fr/$1/$2/$3" "$1-$2-$3" )
}
