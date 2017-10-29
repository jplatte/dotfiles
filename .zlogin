eval $(ssh-agent) >/dev/null

if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    exec startx
fi
