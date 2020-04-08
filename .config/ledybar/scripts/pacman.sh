#!/usr/bin/env bash
update_count=$(checkupdates | wc -l)
[[ "$update_count" > 0 ]] && printf '\uf187 %s' "$update_count"
