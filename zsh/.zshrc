###############
#  Quick Fix  #
###############

case "$TERM" in
    xterm*) TERM=xterm-256color
esac

#############
#  Plugins  #
#############

autoload -U colors && colors
autoload -U zmv
setopt extended_glob

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz compinit; compinit

############
#  Prompt  #
############

# Example prompts:
# potato:git/kicad %                     (field_autoplace) [ 15:47 ]
# ::allium:~ %                                             [ 15:48 ]

if [ "$SSH_CLIENT" ] || [ "$SSH_TTY" ]; then
    SSH_PROMPT="::"
else
    SSH_PROMPT=""
fi

#if [ -d "$HOME/git/zsh-git-prompt" ]; then
#    #GIT_PROMPT_EXECUTABLE=haskell
#    source "$HOME/git/zsh-git-prompt/zshrc.sh"
#    RPROMPT_GIT='$(git_super_status)'
#elif [ -d "$HOME/.oh-my-zsh" ]; then
#    export ZSH=~/.oh-my-zsh
#    plugins=(gitfast vi-mode)
#    source $ZSH/oh-my-zsh.sh
#    unalias -m '*'  # oh-my-zsh is nice, but I don't want your fucking aliases!
#    RPROMPT_GIT='$(git_prompt_info)'
#fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$fg[green]%}"
PROMPT="${SSH_PROMPT}%{$fg[yellow]%}%m:%{$fg[green]%}%2~ %# %{$reset_color%}"
RPROMPT_EXIT="%{$fg[red]%}%(?..[%?] )"
RPROMPT_TIME="%{$fg[green]%}[ %T ]"
RPROMPT="${RPROMPT_EXIT}${RPROMPT_GIT}${RPROMPT_TIME}""%{$reset_color%}"

function zle-line-init zle-keymap-select {
    RPS1="${RPROMPT}" # ${${KEYMAP/vicmd/-N-}/(main|viins)/-I-}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


###########################################
#  Editor, editing mode, completion, etc  #
###########################################

EDITOR=vim
export EDITOR
bindkey -v
export KEYTIMEOUT=1

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list '' 'r:|?=** m:{a-z\-}={A-Z\_}'


#################
#  Keybindings  #
#################

# Every fucking home/end/C-left/C-right sequence imagineable. I have no idea
# how I managed to get these fucked up between computers.

bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\eOD" backward-word
bindkey "\eOC" forward-word
#bindkey "\e[3~" backward-delete-char
bindkey "\e[3~" delete-char

# ls *up* searches through commands matching ^ls
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end
bindkey '^[OA' history-beginning-search-backward-end
bindkey '^[OB' history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward


################################
#  Navigation, system aliases  #
################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ..l="cl .."
alias ...l="cl ../.."
alias ....l="cl ../../.."
cl () { cd "$1"; l }
md () { mkdir -p "$1"; cd "$1" }

alias df="df -h"
alias ll="\ls -alGh --color"
alias ls="\ls -Fh --color"
alias la="l -a"
alias llg="ll | grep"
alias lsg="ls | grep"
function lsl() { \ls -F "$@" | less }
function lll() { \ls -alGh "$@" | less }
alias mv="mv -i"
alias cp="cp -i"
last () {
    \ls -alt "${1:=.}" | head -n "${2:=10}"
}

l () {
    local lines="$(ls -l "$@" | wc -l)" 2>/dev/null
    local lim=$(expr 5 '*' $(tput lines) / 6)
    if [[ $lines -le $lim ]]; then
        ls -l "$@"
    else
        ls "$@"
    fi
}

mtd () {
    # Make TempDir
    TEMPDIR=$(mktemp -d)
    cd "$TEMPDIR"
}

rmtd () {
    # Actually "ReMove This Dir", but also works for "Remove TempDir" as
    # companion to mtd...
    cd ..
    rm -rfvI "$OLDPWD"
}

alias sewdo=sudo
alias sctl="sudo systemctl"
alias jctl="sudo journalctl"
alias psa="ps aux"
alias psg="ps aux | grep "
function tma { tmux attach -d || tmux new-session }
alias rlm="readlink -m"
alias wget!="wget -c --tries=0 --read-timeout=20"
alias dmt="dmesg | tail"
alias dmw="dmesg -w"
function pm {
    pmount "/dev/$1"; cd "/media/$1"
}
alias pum=pumount
function nh { nohup "$@" >/dev/null 2>&1 &; rm -f nohup.out }
function rainbow {
    yes "$(seq 231 -1 16)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done
}

alias vm="vboxmanage startvm"
alias vms="vboxmanage list vms"
function vmh { vboxmanage startvm "$1" --type headless; echo rdesktop -P -z potato:3389 }

################################
#  Package management aliases  #
################################

alias paci="sudo pacman -S"
alias pacs="pacman -Ss"
alias pacu="sudo pacman -Sy"
alias pacug="sudo pacman -Syu"
alias auri="pacaur -S"
alias aurs="pacaur -Ss"
alias auru="pacaur -Sy"
alias aurug="pacaur -Syu"
alias aurls="pacman -Qqe"
alias aurg="pacman -Qqe | grep"
alias apti="sudo apt install"
alias apts="apt search"
alias aptu="sudo apt update"
alias aptug="sudo apt update; sudo apt upgrade"
alias repo-giraffe="repo-elephant && echo Just pretend I\'m a giraffe."
pak () {
    cd $HOME/src
    yaourt -G "$1"
    cd "$1"
}



#########################
#  Development aliases  #
#########################

alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitb="git branch"
alias gitl="git log"
alias gitco="git checkout"
alias gitm="git merge"
alias gitdt="git difftool -t meld --dir-diff"
alias gitf="git fetch"
alias gitr="git rebase"
alias gitmeld="git difftool -t meld --dir-diff"
alias gitd="git diff"
alias gitds="git diff --staged"
alias gith="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias gitrh="git reset --hard"
alias gitcp="git cherry-pick"
alias gitp="git pull"
alias gitP="git push"
alias gitpum="git pull upstream master"
alias gitPum="git push upstream master"
alias gitpom="git pull origin master"
alias gitPom="git push origin master"
clewn!() { clewn -va -R -ga "$*" }
alias clip="xclip -selection clipboard"
alias ssr="simplescreenrecorder"
alias keys="key-mon --key-timeout=0.1 -t classic"
alias vim="nvim"
alias gdb="gdb --quiet"

alias cal="cal -w -3"
alias mls="tree -d -L 3 ~/Music | less"
alias bzrs="bzr status"
alias bzra="bzr add"
alias bzrc="bzr commit"
alias bzrb="bzr branch"
bzrl() { bzr log "$@" | less }

cdl(){ colordiff "$1" | less }

hd(){ hexdump -C "$1" | less }

# Work related
pmount() {
  parted -m $1 unit B print 2>/dev/null |head -$(expr $2 + 2) 
  #|  cut -d':' -f$2
fdisk -l $1 | grep $1$2
}

lgmake() {
    docker run --privileged=true --rm -e BUILD -e IMAGE -v "$(git rev-parse --show-toplevel):/src" -w "/src/$(realpath --relative-base=$(git rev-parse --show-toplevel) .)" enxbuild2:v2 make $*
}

bake() {
#docker run --rm -v "/home/jbj/devel/ambu:/src"            -v /etc/hosts:/etc/hosts -v /home/jbj/.ssh:/home/build/.ssh -v /home/jbj/.gitconfig:/home/build/.gitconfig -v /build:/build -w /src/base-yocto --net=host -ti yocto-builder:v2 /bin/bash
#docker run --rm -v "/home/jbj/devel/ambu/base-yocto:/src" -v /etc/hosts:/etc/hosts -v /home/jbj/.ssh:/home/build/.ssh -v /home/jbj/.gitconfig:/home/build/.gitconfig -v /build:/build -w /src/yocto_build --net=host -ti yocto-builder:v2 /bin/bash
#    docker run --rm -v "/home/jbj/devel/ambu:/src" -v /etc/hosts:/etc/hosts -v /build:/build -w /src/base-yocto/yocto_build --net=host -ti yocto-builder:v2 /bin/bash #-c "ls && source ../poky/oe-init-build-env . && bitbake amp"

    docker run --rm \
        -v "/home/jbj/devel/ambu:/src" \
        -v /etc/hosts:/etc/hosts \
        -v /home/jbj/.ssh:/home/build/.ssh \
        -v /home/jbj/.gitconfig:/home/build/.gitconfig \
        -v /build:/build \
        -w /src/base-yocto \
        --device=/dev/net/tun \
        --net=host \
        -ti yocto-builder:v2 /bin/bash
}
function coffee()
{
    echo "The coffee is $(curl -L https://api.thingspeak.com/channels/332399/fields/7/last -s) minutes old."
}

#####################
#  todo.sh aliases  #
#####################

alias toa="todo.sh add"
alias tol="todo.sh ls"
alias tor="todo.sh rm"
alias tou="todo.sh replace" # item "UPDATED"
alias tod="todo.sh do"


##################################
#  Networking aliases/functions  #
##################################

function sshfs_mount() {
    # $1 = name of ~/media subdirectory
    # $2 = host including user and path
    # $3 - optional = default directory on host to cd into
    local OLD_OLDPWD="$OLDPWD"
    local OLD_PWD="$PWD"
    cd ~/media
    fusermount -uq "$1"
    mkdir -p "$1"
    if ! sshfs -p 8089 "$2" "$1" -oauto_cache,reconnect,no_readahead; then
        cd "$OLD_PWD"
        OLDPWD="$OLD_OLDPWD"
    else
        cd "$1/$3"
    fi
}

function sshfs_umount() {
    # $1 = name of ~/media subdirectory
    local FULL_PWD="$(readlink -m "$PWD")"
    local FULL_MOUNTDIR="$(readlink -m "$HOME/media/$1")"
    if [[ "$FULL_PWD" == "$FULL_MOUNTDIR"* ]]; then
        cd "$FULL_MOUNTDIR/.."
    fi
    fusermount -uq "$HOME/media/$1"
    RETURNCODE=$?
    if [[ $RETURNCODE -ne 0 ]]; then

        echo "Couldn't unmount the directory"
        return $RETURNCODE
    fi
}

function music:()  { sshfs_mount  music jonas@jalling.net:/mnt/smb_media/music }
function music:u() { sshfs_umount music }
function media:()  { sshfs_mount  media jonas@jalling.net:/mnt/smb_media }
function media:u() { sshfs_umount media }

####################
#  Frou-frou bits  #
####################

update-title()
{
    case $TERM in
        xterm* | screen* | rxvt*)
            print -Pn "\e]0;%~\a"
            ;;
    esac
}

precmd () {
    update-title
}

# Write the last command to the terminal title
preexec() { print -Pnr $'\033'"]2;%~ [ $1 ]"$'\a' }

source ~/.zshenv

