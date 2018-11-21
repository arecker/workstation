export EDITOR="nano"
export PATH="$HOME/bin:$PATH"
export PS1="\u@\h:\w\$ "

# aliases
alias be="bundle exec"
alias aws-whoami="aws sts get-caller-identity"
if [ "$(uname)" != "Darwin" ]; then
    alias ls="ls --color"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# ssh
ssh-add -k ~/.ssh/personal 2>/dev/null
if [ -f "$HOME/.ssh/work/id_rsa" ]; then
    ssh-add -k ~/.ssh/work/id_rsa 2>/dev/null
fi
