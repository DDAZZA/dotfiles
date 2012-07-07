export GIT_PS1_SHOWDIRTYSTATE=true

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

export EDITOR='vim'
# export PATH="$HOME/.local/bin:$PATH"

# eval "$(ry setup)"
# export RY_PREFIX="$HOME/.local"
# export PATH="$RY_PREFIX/lib/ry/current/bin:$PATH"

alias be='bundle exec'
alias gi='gem install $1 --no-rdoc --no-ri'
# alias ack='ack-grep'
alias ll='ls -al'
alias gs='git status'

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source ~/.bash_extra # extra configuration for specific computer
