#!/bin/bash
cd "/sys/class/power_supply/$1/"

status=$(cat status)
energy_f=$(( 100 * $(cat energy_now) / $(cat energy_full) ))

if [[ "$status" == 'Unknown' ]] && (( $(cat power_now) == 0 )); then
    status='Full'
fi

if [[ "$status" == 'Charging' ]]; then
    class='charging'
elif [[ "$status" == 'Discharging' || "$status" == 'Not charging' ]]; then
    class='' # Do nothing
elif [[ "$status" == 'Full' ]]; then
    text=$(printf '<span color="#888">\uf0e7</span> ')
    class='full'
else
    text="[$status] "
    class='error'
fi

energy_d=$((100 * $(cat energy_now) / $(cat energy_full_design)))

if [[ "$status" == 'Charging' || "$status" == 'Discharging' ]]; then
    power=$(cat power_now | awk '{ printf "%.1f", $1 * 1e-6 }')
    text+=$(printf '%s\u2009W, ' "$power")
fi

if [[ "$status" == 'Discharging' ]]; then
    if [[ "$energy_d" -lt 10 ]]; then
        class='very-low'
    elif [[ "$energy_d" -lt 20 ]]; then
        class='low'
    fi
fi

text+=$(printf '%s\u2009%%' "$energy_d")

jq -nc '{ "text": $ARGS.named.text, "class": $ARGS.named.class, "percentage": $ARGS.named.energy_f }' \
    --arg text "$text" --arg class "$class" --argjson energy_f "$energy_f"
