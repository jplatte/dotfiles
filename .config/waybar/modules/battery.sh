#!/bin/bash
cd "/sys/class/power_supply/$1/"

status=$(cat status)
energy_f=$((100 * $(cat energy_now) / $(cat energy_full)))

if [[ "$status" == 'Charging' ]]; then
    class='charging'
elif [[ "$status" == 'Discharging' ]]; then
    # Does not currently affect styling, but why not
    class='discharging'
elif [[ "$status" == 'Full' ]]; then
    text=$(printf '\uf0e7')
    class='full'
else
    text="[$status]"
    class='error'
fi

if [[ "$status" == 'Charging' || "$status" == 'Discharging' ]]; then
    power=$(cat power_now | awk '{ printf "%.1f", $1 * 1e-6 }')
    energy_d=$((100 * $(cat energy_now) / $(cat energy_full_design)))

    text+=$(printf '%s\u2009W, %s\u2009%%' "$power" "$energy_d")

    if [[ "$energy_d" -lt 10 ]]; then
        class='very-low'
    elif [[ "$energy_d" -lt 20 ]]; then
        class='low'
    fi
fi

jq -nc '{ "text": $ARGS.named.text, "class": $ARGS.named.class, "percentage": $ARGS.named.energy_f }' \
    --arg text "$text" --arg class "$class" --argjson energy_f "$energy_f"
