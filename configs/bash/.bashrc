export HISTSIZE="500"
export HISTFILE="$HOME/.bash_history"
export PS1="\u@localhost:\w\$ "

is_mac() {
    [[ "$(uname)" == "Darwin" ]]
}

is_arm() {
    [[ "$(uname -m)" == "arm64" ]]
}

# aliases
alias be="bundle exec"
alias k='kubectl'

if ! is_mac; then
    alias ls="ls --color"
fi

# add homebrew path
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH" # prefer brew java over system
fi

# emacs
if is_mac; then  # the emacsclient binary is buried somewhere in the EmacsForOSX application
    if is_arm; then
        export PATH="/Applications/Emacs.app/Contents/MacOS/bin-arm64-11/:$PATH"
    else
        export PATH="/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_14/:$PATH"
    fi
fi
export EDITOR="emacsclient"
export GPG_TTY=$(tty)

# asdf
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
if [ -d "$HOME/.asdf" ]; then
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"
fi

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

cowsay "$(fortune)" || echo "Warning: cowsay is not installed (you might literally die)"
