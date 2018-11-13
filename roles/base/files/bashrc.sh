export PS1="\u@\h:\w\$ "
export PATH="$HOME/bin:$PATH"
export EDITOR="emacsclient"

# aliases
alias be="bundle exec"

if [[ "$(uname)" != "Darwin" ]]; then
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
