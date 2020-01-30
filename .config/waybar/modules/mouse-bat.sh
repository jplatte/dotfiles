#!/bin/bash

info_line=$(solaar show | grep Battery | grep -v offline)
percentage=$(sed 's/\s*Battery: \([0-9]\+\)%.*/\1/' <<< $info_line)

if ( grep -q recharging <<< "$info_line" ); then
    jq -nc '{ "percentage": $ARGS.named.p, "class": "charging" }' --argjson p "$percentage"
else
    jq -nc '{ "percentage": $ARGS.named.p }' --argjson p "$percentage"
fi
