# PATH
typeset -U path
path=($path[@] ~/.local/bin ~/.cargo/bin ~/.local/share/npm/bin)

# Overwrite zsh defaults for up and down (make it cycle the history unfiltered)
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-history

# Aliases
alias cal='cal -3'
alias diff='diff --color=auto'
alias ip='ip -c'
alias lumeo-db-up='sudo systemctl start docker && sudo docker-compose up db'

# When using sudo, use alias expansion (otherwise sudo ignores aliases)
alias sudo='sudo '

# Command not found
source /usr/share/doc/pkgfile/command-not-found.zsh

# roxterm and lxterm don't indicate 256color support
#export TERM=xterm-256color

# Dotnet telemetry?!
export DOTNET_CLI_TELEMETRY_OPTOUT=1
