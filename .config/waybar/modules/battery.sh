#!/bin/bash
cd "/sys/class/power_supply/$1/"

# use percentage of intended-maximum charge / energy, not currently-maximum
full=full_design

status=$(cat status)
if [[ -e charge_now && -e charge_${full} ]]; then
    value_full=$(( 100 * $(cat charge_now) / $(cat charge_${full}) ))
elif [[ -e energy_now && -e energy_${full} ]]; then
    value_full=$(( 100 * $(cat energy_now) / $(cat energy_${full}) ))
else
    text=$(printf '\ufffd ')
    class='error'
fi

if [[ "$status" == 'Charging' ]]; then
    class='charging'
elif [[ "$status" == 'Discharging' || "$status" == 'Not charging' ]]; then
    class='' # Do nothing
elif [[ "$status" == 'Full' ]] || [[ "$status" == 'Unknown' && -e power_now ]] && (( $(cat power_now) == 0 )); then
    text=$(printf '<span color="#888">\uf0e7</span> ')
    class='full'
elif [[ "$status" == 'Unknown' ]]; then
    text=$(printf '\ufffd ')
    class='error'
else
    text="[$status] "
    class='error'
fi

if [[ "$status" == 'Charging' || "$status" == 'Discharging' && -e power_now ]]; then
    power=$(awk '{ printf "%.1f", $1 * 1e-6 }' < power_now)
    text+=$(printf '%s\u2009W, ' "$power")
fi

if [[ "$status" == 'Discharging' ]]; then
    if [[ "$value_full" -lt 10 ]]; then
        class='very-low'
    elif [[ "$value_full" -lt 20 ]]; then
        class='low'
    fi
fi

text+=$(printf '%s\u2009%%' "$value_full")

jq -nc '{ "text": $ARGS.named.text, "class": $ARGS.named.class, "percentage": $ARGS.named.value_full }' \
    --arg text "$text" --arg class "$class" --argjson value_full "$value_full"
