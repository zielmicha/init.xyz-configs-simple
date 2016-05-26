setopt interactivecomments
autoload -Uz promptinit
promptinit

# Replicate emacs behavior
bindkey -e

bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
export WORDCHARS=''

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -U select-word-style
select-word-style bash

# Prompt

autoload -U colors && colors
fg[purple]=$'\e[0;35m'

if [[ $UID = 0 ]]; then
   export PROMPT="%{$fg[red]%}%m%{$reset_color%} %{$fg[purple]%}%~%{$reset_color%}] "
else
   _hostname=$(</etc/hostname)
   if [[ $_hostname =~ '\.' ]]; then
      export PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%} %{$fg[purple]%}%~%{$reset_color%}] "
   else
      export PROMPT="%{$fg[green]%}${HADES_PROFILE:%n}%{$reset_color%} %{$fg[purple]%}%~%{$reset_color%}] "
   fi
fi

# Git prompt

if [ -e ~/apps/zsh-git-prompt/zshrc.sh ]; then
    ZSH_THEME_GIT_PROMPT_CACHE=1
    GIT_PROMPT_EXECUTABLE=haskell
    source ~/apps/zsh-git-prompt/zshrc.sh

    rprompt_cmd() {
        echo "$(git_super_status) $(date +"%H:%M:%S")"
    }
else
    rprompt_cmd() {
    }
fi

# History
setopt histignorealldups
setopt sharehistory

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# from http://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history/691603

bindkey "${key[Up]}" up-line-or-local-history
bindkey "${key[Down]}" down-line-or-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

# Completion

autoload -Uz compinit
compinit
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Programs

[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
[[ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]] \
   && source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

# Terminal title

title_precmd () {print -Pn "\e]0;$PWD\a"}
title_preexec() {print -Pn "\e]0;$PWD: $2\a"}

add-zsh-hook precmd title_precmd
add-zsh-hook preexec title_preexec

# Aliases

alias sudo="sudo -H"
alias apt="sudo apt install"
alias apt-search="apt-cache search"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color"
alias mv="mv -i"
alias cp="cp -i"
alias l=ls
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"
alias grep="grep --color=auto"
alias sl=ls
alias sls=ls
alias lss=ls
alias ks=ls
alias sk=ls
alias lks=ls
alias ack="ack-grep"
IPYTHON_OPTIONS="--no-confirm-exit --no-banner"
alias py="ipython3 $IPYTHON_OPTIONS"
alias py2="ipython $IPYTHON_OPTIONS"
alias py3="ipython3 $IPYTHON_OPTIONS"

# Ccache

export USE_CCACHE=1

# Misc

REPORTTIME=10 # print process time after $REPORTTIME seconds

# Highlighting

if [ -e ~/apps/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
    source ~/apps/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# GPG/SSH

export SSH_AUTH_SOCK="${HOME}/.ssh/agent.sock"

