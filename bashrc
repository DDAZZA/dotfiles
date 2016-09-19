export MYSQL_PS1="\u@\h [\d]> "
export EDITOR='vim'

alias be='bundle exec'
alias gsl='clear; git status -sb'
alias tmux='tmux -2'
alias bye='pkill -1 sshd'
alias tmux-git='tmux -2 new -s $(basename $(pwd))'
# alias myip='curl ifconfig.me' # get my ip
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias docker_rmi='docker rmi -f $(docker images -q -a -f dangling=true)' # Removes all untagged images
alias docker_rmc='docker rm $(docker ps -a -q)'    # Remove all containers
alias docker_rmv='docker volume rm $(docker volume ls -q )' # Remove used volumes
alias docker_rmn='docker network rm $(docker network ls -q )' # Remove used volumes
alias docker_stats='docker stats $(docker ps --format={{.Names}})'
alias docker_rma='docker_rmi; docker_rmc; docker_rmv;' # Remove all

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
  echo "aws ecr get-login"
  login=`aws ecr get-login $@`

  read -p "$login ? [y/N]" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    eval $login
  fi
}
