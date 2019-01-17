#!/bin/bash
# \xe2\x80\x89 is the utf8 representation of \u2009
btrfs filesystem usage -H -T "$1" \
    | grep '^\s\+Free' \
    | sed 's/[^:]\+:\s\+\([0-9]\+\)\(\.[0-9]\+\)\?\(\w\+\).*/\1\xe2\x80\x89\3/'
