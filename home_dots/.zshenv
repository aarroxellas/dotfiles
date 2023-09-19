export ZDOTDIR=$HOME/.config/zsh
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export VISUAL='nvim'
export EDITOR=${VISUAL}
export GIT_EDITOR=${VISUAL}
# eval "`pip completion --zsh`"
[ "$(uname)" = "Linux" ] && \
	export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

[ "$(uname)" = "Darwin" ] && \
	export BROWSER="open -a Google\ Chrome.app"

# Add ASDF plugin
[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh ||
	[ -f /opt/asdf-vm/asdf.sh ] && source /opt/asdf-vm/asdf.sh
[ -f $HOME/.asdf/plugins/java/set-java-home.zsh ] && source $HOME/.asdf/plugins/java/set-java-home.zsh
# completions for asdf to fpath
fpath=(${ASDF_DIR}/completions $fpath)

export PYENV_ROOT=$HOME/.config/pyenv/
export NVM_DIR=$HOME/.config/nvm

# Global config for permissions on NodeJS (https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)
[ -d $HOME/.npm-global ] ||  mkdir ~/.npm-global && npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH

# GO
# export PATH=$HOME/.local/share/go/bin:$PATH
# export GOPATH=$HOME/.local/share/go

# Golang
[ -x "$(command -v go)" ] && export PATH="$PATH:$(go env GOPATH)/bin"

# PY_ENV
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init -)"

# NVM
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Ruby - gems TODO: make universal
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH
. "$HOME/.cargo/env"

[ "$(uname)" = "Linux" ] && \
    setxkbmap -option caps:escape_shifted_capslock && \
    xset r rate 200 65

# ASDF VERSION PATH
java_version() {
    VER=$(asdf list "$1" | grep -oE "$2[0-9.+]+" | sort | head -1)
    [ ! -z $VER ] && \
        asdf where $1 $VER
}
export ASDF_PYTHON_VERSION=system

alias 'jdtls=~/.local/share/jdtls/bin/jdtls -configuration ~/.cache/jdtls/config_linux -data /home/aarroxellas/.cache/jdtls-workspace 2>/dev/null'
alias 'checkstyle=checkstyle -c /home/aarroxellas/.config/checkstyle/google_checks.xml'

