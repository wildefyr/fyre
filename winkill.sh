#!/bin/sh
#
# wildefyr - 2016 (c) MIT
# i was happy with killwa before telegram showed up in my life

usage() {
    cat << EOF
Usage: $(basename $0) [wid]
EOF

    test $# -eq 0 || exit $1
}

case $1 in
    0x*) wid=$1  ;;
    *)   usage 1 ;;
esac

. fyrerc.sh

case "$(class $wid)" in
    "telegram")
        printf '%s\n' "you're terminated fucker."
        killw $wid
        ;;
    "Wine")
        killw $wid
        ;;
    "google-chrome")
        pkill chrome
        ;;
    *)
        killwa $wid
        ;;
esac

windows.sh -c $wid
