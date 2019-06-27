#!/bin/bash
[[ $(nmcli -f wifi -t g s) == 'disabled' ]] && exit 0

iface="$1"

network_name=$(
    nmcli -t -f name,device c s -a \
        | grep ":${iface}$" \
        | cut -d':' -f1
)

if [[ -z $network_name ]]; then
    printf 'disconnected\n\ndisconnected\n'
else
    freq=$(iwconfig | grep -q 'Frequency:2' && printf '2.4' || printf '5')

    link_quality=$(
        iwconfig \
            | grep 'Link Quality' \
            | sed 's/\s\+Link Quality=\([0-9]\+\/[0-9]\+\).*/\1/'
    )

    if [[ $(bc <<< "scale=2; $link_quality < 0.6") == 1 ]]; then
        class='good-link-q'
    else
        color='bad-link-q'
    fi

    freq_text=$(printf '%s\u2009GHz' "$freq")
    echo "$network_name ($freq_text)"
    echo
    echo "$class"
    #printf '%s (%s\u2009GHz)\n\n%s' "$network_name" "$freq" "$class"
fi
