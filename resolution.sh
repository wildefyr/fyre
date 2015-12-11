#!/bin/sh
#
# wildefyr - 2015 (c) wtfpl
# find resoluton of mpv video based on window id

usage() {
    printf '%s\n' "usage: $(basename $0) <mpvwid>"
    exit 1
}

test -z $1 && usage

wid=$1

if [ $(wclass.sh m $wid) = "mpv" ]; then
    printf '%s\n' "$(xprop -id $(wid.sh mpv) WM_NORMAL_HINTS | sed '5s/[^0-9]*//p;d' | tr / \ )"
else
    usage
fi
