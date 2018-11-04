export PS1="\u@\h:\w\$ "
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export EDITOR="emacsclient"

# aliases
alias ls="ls --color"
alias be="bundle exec"

# python
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# ruby
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
