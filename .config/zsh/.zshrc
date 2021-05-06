# PATH
typeset -U path
path=($path[@] ~/.local/bin ~/.cargo/bin ~/.local/share/npm/bin)

# Overwrite zsh defaults for up and down (make it cycle the history unfiltered)
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-history

# Aliases
alias cal='command cal -3'
alias diff='command diff --color=auto'
alias l='command ls -lvh --color=auto'
alias la='command ls -lavh --color=auto'
alias lsof='command lsof -P'
alias ip='command ip -c'
alias lumeo-dc-start='sudo systemctl start docker && sudo docker-compose start db mqtt fs'

# When using sudo, use alias expansion (otherwise sudo ignores aliases)
alias sudo='sudo '

# Command not found
source /usr/share/doc/pkgfile/command-not-found.zsh

# roxterm and lxterm don't indicate 256color support
#export TERM=xterm-256color

# Dotnet telemetry?!
export DOTNET_CLI_TELEMETRY_OPTOUT=1
