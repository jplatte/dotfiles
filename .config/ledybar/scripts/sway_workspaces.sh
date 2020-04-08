#!/usr/bin/env bash

while read -r _; do
    while read -r _; do
    done < <(swaymsg -t get_workspaces | jq -c '.[]')
    notify-send "$all"
    #workspaces=$(swaymsg -t get_workspaces)
    #active_workspace=$(jq '.[] | select(.focused)' <<< "$workspaces")
    #name=$(jq -r '.name' <<< "$active_workspace")
    #num=$(jq -r '.num' <<< "$active_workspace")
    #stripped_name=${name#"$num:"}
    #notify-send "$stripped_name"
done < <(swaymsg -mt subscribe '["workspace"]')

