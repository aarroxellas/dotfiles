ZDOTDIR=$HOME/.config/zsh

. /usr/local/opt/asdf/libexec/asdf.sh

#export JDTLS_HOME=$HOME/.local/share/nvim/lsp_servers/jdtls/
# JAVA_HOME=$(/usr/libexec/java_home -v17)
# PATH=$PATH:$JAVA_HOME/bin
# GRADLE_USER_HOME=$HOME/.gradle/
# KOTLIN_HOME=/Users/aarroxellas/.asdf/installs/kotlin/1.8.10/kotlinc

# Locale

export LANG=en_US.UTF-8
export LC_CTYPE=”en_US.UTF-8″
export LC_NUMERIC=”en_US.UTF-8″
export LC_TIME=”en_US.UTF-8″
export LC_COLLATE=”en_US.UTF-8″
export LC_MONETARY=”en_US.UTF-8″
export LC_MESSAGES=”en_US.UTF-8″
export LC_PAPER=”en_US.UTF-8″
export LC_NAME=”en_US.UTF-8″
export LC_ADDRESS=”en_US.UTF-8″
export LC_TELEPHONE=”en_US.UTF-8″
export LC_MEASUREMENT=”en_US.UTF-8″
export LC_IDENTIFICATION=”en_US.UTF-8″
export LC_ALL=$LANG

# IntelliJ IDEA
[ "$(uname)" = "Darwin" ] && alias idea='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'

# Japanese input
[ "$(uname)" = "Linux" ] && export XMODIFIERS=@im=ibus
[ "$(uname)" = "Linux" ] && export GTK_IM_MODULE=ibus
[ "$(uname)" = "Linux" ] && export QT_IM_MODULE=ibus
# [ "$(uname)" = "Linux" ] && export SDL_IM_MODULE=ibus
