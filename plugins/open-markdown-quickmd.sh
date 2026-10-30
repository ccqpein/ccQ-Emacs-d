#!/bin/sh

if [ $# -gt 0 ]; then
    open -a "QuickMD" "$@"
else
    open -a "QuickMD"
fi
