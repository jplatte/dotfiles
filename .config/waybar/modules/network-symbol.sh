#!/bin/bash
(echo start; nmcli monitor) | while read _; do
    state=$(LC_ALL=C nmcli -t -f type,state d)

    if grep -Fq 'ethernet:connected' <<< "$state"; then
        printf '\uf0c1\nconnected via ethernet\n'
    elif grep -Fq 'wifi:connected' <<< "$state"; then
        printf '\uf1eb\nconnected via wifi\n'
    else
        printf '\uf127\ndisconnected\ndisconnected'
    fi
done
