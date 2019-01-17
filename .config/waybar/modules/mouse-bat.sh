#!/bin/bash

info_line=$(solaar show | grep Battery)
percentage=$(sed 's/\s*Battery: \([0-9]\+\)%.*/\1/' <<< $info_line)

if ( grep -q recharging <<< $info_line ); then
    printf '{ "percentage": %s, "class": "charging" }' "$percentage"
else
    printf '{ "percentage": %s }' "$percentage"
fi
