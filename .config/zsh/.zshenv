export EDITOR=nvim

# XDG directories
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# Workarounds for programs that don't follow the XDG spec by default, but can
# be configured to use custom config / data / cache locations.
# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export LESSHISTFILE=-
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
