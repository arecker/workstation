export EDITOR="nano"
export PATH="$HOME/bin:$PATH"
export PS1="\u@\h:\w\$ "

# aliases
alias be="bundle exec"
alias aws-whoami="aws sts get-caller-identity | jq -r '.Arn'"
if [ "$(uname)" != "Darwin" ]; then
    alias ls="ls --color"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  export WORKON_HOME="$HOME/.virtualenvs"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ssh
ssh-add -k ~/.ssh/personal 2>/dev/null
if [ -f "$HOME/.ssh/work/id_rsa" ]; then
    ssh-add -k ~/.ssh/work/id_rsa 2>/dev/null
fi

# gcloud
if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
fi
