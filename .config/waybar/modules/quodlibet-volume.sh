#!/bin/bash
vol=$(~/.local/bin/scripts/quodlibet-volume)
if [[ "$?" == 0 ]]; then
    if [[ "$BLOCK_BUTTON" == 1 ]]; then
        ~/.local/bin/scripts/quodlibet-control play-pause
    fi

    echo "$vol"
fi
