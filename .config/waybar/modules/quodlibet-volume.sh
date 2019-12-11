#!/bin/bash

# Get and optionally updates the volume in quodlibet with logarithmic scale
# rather than the default linear scale.
#
# Usage:
#   Print current volume: quodlibet-volume
#   Update and print volume:
#     quodlibet-volume <volume: int>
#     quodlibet-volume +<increment: int>
#     quodlibet-volume -<decrement: int>

set -eo pipefail

[[ -p ~/.config/quodlibet/control ]]

status_file="$(mktemp)"
printf "\0status\0$status_file\0" > ~/.config/quodlibet/control
cur_vol=$(awk '{ printf "%.f", $3 ^ (1/3) * 100 }' < "$status_file")
rm "$status_file"

change="$1"

if [[ -n "$change" ]]; then
    if [[ "${change::1}" =~ [+-] ]]; then
        vol=$(($cur_vol $1))
    else
        vol="$1"
    fi
    vol_scaled=$(awk '{ print ($1 / 100) ^ 3 * 100 }' <<< $vol)
    printf "\0volume $vol_scaled\0/dev/null\0" > ~/.config/quodlibet/control
else
    vol="$cur_vol"
fi

echo "$vol"
