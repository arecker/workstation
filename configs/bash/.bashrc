export HISTSIZE="500"
export HISTFILE="$HOME/.bash_history"
export PS1="\u@localhost:\w\$ "

is_mac() {
    [[ "$(uname)" == "Darwin" ]]
}

# aliases
alias be="bundle exec"
alias k='kubectl'
alias plexbot="reckerbot --user '#plex'"
alias aws-whoami="aws sts get-caller-identity | jq -r '.Arn'"
alias aws-local='aws --profile local --endpoint-url http://localhost:4566/'

if ! is_mac; then
    alias ls="ls --color"
fi

# add homebrew path
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH" # prefer brew java over system
fi

# emacs
if is_mac; then
    export PATH="/Applications/Emacs.app/Contents/MacOS/bin/:$PATH"
fi
export EDITOR="emacsclient"
export GPG_TTY=$(tty)

# python
export WORKON_HOME="$HOME/.virtualenvs"
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# tfenv
if [ -d "$HOME/.tfenv/bin" ]; then
    export PATH="$HOME/.tfenv/bin:$PATH"
fi

# gcloud
if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
fi

# hack for openvpn installed by homebrew
if [ "$(uname)" == "Darwin" ]; then
    export PATH="/usr/local/sbin:$PATH"
fi

# GO
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# local bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Load work stuff
if [ -f "$HOME/bin/bashrc-work" ]; then
    source "$HOME/bin/bashrc-work"
fi

########################################################################
# # This is for things I don't use, but they are there if I need them. #
########################################################################

# rust
# if [ -d "$HOME/.cargo/env" ]; then
#     . "$HOME/.cargo/env"
# fi

# asdf
# if [ -d "$HOME/.asdf" ]; then
#     . "$HOME/.asdf/asdf.sh"
# fi

# nodenv
# (uncomment if this language ever becomes cool again)
# if [ -d "$HOME/.nodenv" ]; then
#     export PATH="$HOME/.nodenv/bin:$PATH"
#     eval "$(nodenv init -)"
# fi

# poetry
# if [ -d "$HOME/.poetry/bin" ]; then
#     export PATH="$HOME/.poetry/bin:$PATH"
# fi

# cowsay "$(fortune)" || echo "Warning: cowsay is not installed (you might literally die)"
fortune --comment '## ' --wrap 72
