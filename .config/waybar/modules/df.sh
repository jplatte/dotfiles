#!/bin/bash
# \xe2\x80\x89 is the utf8 representation of \u2009
df -H --output=avail "$1" \
    | tail -n1 \
    | sed 's/\s*\([0-9.]\+\)\(\w\)\s*/\1\xe2\x80\x89\2/'
