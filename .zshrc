# PATH
typeset -U path
path=($path[@] ~/.local/bin ~/.cargo/bin ~/.npm-packages/bin)

# Aliases
alias ip='ip -c'
alias diff='diff --color=auto'
alias ssh="ssh-add -l > /dev/null || ssh-add && unalias ssh; ssh"
alias launch-testing-chroot="sudo arch-chroot /opt/arch-testing /bin/sh -c 'cd /root && /bin/zsh'"
alias rg='rg --no-ignore-vcs'
alias aurman='aurman --show_changes'

# When using sudo, use alias expansion (otherwise sudo ignores aliases)
alias sudo='sudo '

# Command not found
source /usr/share/doc/pkgfile/command-not-found.zsh

# roxterm and lxterm don't indicate 256color support
#export TERM=xterm-256color

# Make `npm install -g` user-wide instead of system-wide
NPM_PACKAGES="$HOME/.npm-packages"

# Dotnet telemetry?!
export DOTNET_CLI_TELEMETRY_OPTOUT=1
