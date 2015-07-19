export MYSQL_PS1="\u@\h [\d]> "

export EDITOR='vim'

alias be='bundle exec'
alias gsl='clear; git status -sb'
alias ll='ls -al'
alias tmux='tmux -2'
alias bye='pkill sshd'

# alias myip='curl ifconfig.me' # get my ip
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'



if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi

if [ -f ~/.git-prompt.sh ]; then
  export GIT_PS1_SHOWDIRTYSTATE=true
  export PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
  source ~/.git-prompt.sh
fi

if [ -f ~/.bash_extra ]; then
  source ~/.bash_extra # extra configuration for specific computer
fi
