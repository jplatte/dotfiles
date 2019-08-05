#!/bin/bash
update_count=$(checkupdates | wc -l)
[[ "$update_count" > 0 ]] && echo "$update_count"
