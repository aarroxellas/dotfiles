ZDOTDIR=$HOME/.config/zsh
export ZDOTDIR

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

# Japanese input
if [ "$(uname)" = "Linux" ]; then
	export XMODIFIERS=@im=ibus
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	# export SDL_IM_MODULE=ibus
fi

