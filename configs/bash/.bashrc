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

# asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# hack for openvpn installed by homebrew
if [ "$(uname)" == "Darwin" ]; then
    export PATH="/usr/local/sbin:$PATH"
fi

# local bin
export PATH="$HOME/bin:$PATH"

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
