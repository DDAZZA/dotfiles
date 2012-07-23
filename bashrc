export GIT_PS1_SHOWDIRTYSTATE=true

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

export EDITOR='vim'

alias be='bundle exec'
alias gs='git status'
alias gsl='clear; git status'
alias gi='gem install $1 --no-rdoc --no-ri'
alias ll='ls -al'
alias gs='git status'
alias tmux='tmux -2'

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source ~/.bash_extra # extra configuration for specific computer
