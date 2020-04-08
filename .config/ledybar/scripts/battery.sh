#!/usr/bin/env bash
if (( $# < 1 )); then
    echo 'BAT?'
    exit 1
fi

cd "/sys/class/power_supply/$1/"

status=$(cat status)
energy_d=$(( 100 * $(cat energy_now) / $(cat energy_full_design) ))
energy_f=$(( 100 * $(cat energy_now) / $(cat energy_full) ))

if [[ "$status" == 'Unknown' ]] && (( $(cat power_now) == 0 )); then
    status='Full'
fi

html='<span class="grey">'

if (( "$energy_f" <= 20 )); then
    html+=$(printf '\uf244')
elif (( "$energy_f" <= 40)); then
    html+=$(printf '\uf243')
elif (( "$energy_f" <= 60)); then
    html+=$(printf '\uf242')
elif (( "$energy_f" <= 80)); then
    html+=$(printf '\uf241')
else
    html+=$(printf '\uf240')
fi

html+='</span> '

if [[ "$status" == 'Charging' ]]; then
    class='charging'
elif [[ "$status" == 'Discharging' || "$status" == 'Not charging' ]]; then
    true # Do nothing
elif [[ "$status" == 'Full' ]]; then
    html+=$(printf '<span class="grey">\uf0e7</span> ')
    class='full'
else
    html+="[$status] "
    class='error'
fi

if [[ "$status" == 'Charging' || "$status" == 'Discharging' ]]; then
    power=$(cat power_now | awk '{ printf "%.1f", $1 * 1e-6 }')
    html+=$(printf '%s\u2009W, ' "$power")
fi

if [[ "$status" == 'Discharging' ]]; then
    if [[ "$energy_d" -lt 10 ]]; then
        class='very-low'
    elif [[ "$energy_d" -lt 20 ]]; then
        class='low'
    fi
fi

html+=$(printf '%s\u2009%%' "$energy_d")

jq -nc '{ "html": $ARGS.named.html, "classes": [$ARGS.named.class] }' \
    --arg html "$html" --arg class "$class"
