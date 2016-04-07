export MYSQL_PS1="\u@\h [\d]> "
export EDITOR='vim'

alias be='bundle exec'
alias gsl='clear; git status -sb'
alias tmux='tmux -2'
alias bye='pkill -1 sshd'
alias git-tmux='tmux new -s $(basename $(pwd))'

# alias myip='curl ifconfig.me' # get my ip
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias docker_rmi='docker rmi -f $(docker images -q -a -f dangling=true)' # Removes all untagged images
alias docker_rmc='docker rm $(docker ps -a -q)'    # Remove all containers

if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;00m\] \$ '

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  export GIT_PS1_SHOWDIRTYSTATE=true
  export PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi

if [ -f ~/.bash_extra ]; then
  source ~/.bash_extra # extra configuration for specific computer
fi

function gorun {
  docker run --rm -it \
    -P -p 8080:8080 \
    -e GOBIN=/go/bin \
    -v `pwd`:/go golang \
    go $*
}

function aws_refresh_ecr_token() {
  echo 'aws ecr get-login'
  aws ecr get-login
}
