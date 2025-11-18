#!/bin/bash
if [[ $(nmcli -f wifi -t g s) == 'disabled' ]]; then
    jq -nc '{ "text": "", "class": "disabled" }'
    exit 0
fi

iface="$1"

if [[ -z "$iface" ]]; then
    echo 'usage: $0 <network_device>' >&2
    exit 1
fi

network_name=$(
    nmcli -t -f name,device c s -a \
        | grep ":${iface}$" \
        | cut -d':' -f1
)
iwconfig_out=$(iwconfig "$iface")

if [[ -z "$network_name" ]]; then
    jq -nc '{ "text": $ARGS.named.text, "class": "disconnected" }' --arg text '<span color="#c43030"></span> disconnected'
elif ( grep -qF 'ESSID:off/any' <<< "$iwconfig_out" ); then
    jq -nc '{ "text": " connecting…", "class": "connecting" }'
else
    freq=$(iwconfig "$iface" | grep -q 'Frequency:2' && printf '2.4' || printf '5')

    link_quality=$(
        echo "$iwconfig_out" \
            | grep 'Link Quality' \
            | sed 's/\s\+Link Quality=\([0-9]\+\/[0-9]\+\).*/\1/'
    )

    if [[ $(bc <<< "scale=2; $link_quality < 0.6") == 1 ]]; then
        color="#eebf13"
    else
        color="#3c913b"
    fi

    text=$(printf '<span color="%s"></span> %s (%s\u2009GHz)' "$color" "$network_name" "$freq")
    jq -nc '{ "text": $ARGS.named.text }' --arg text "$text"
fi
