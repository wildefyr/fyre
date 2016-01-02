#!/bin/sh
#
# wildefyr - 2015 (c) wtfpl
# move and resize windows to useful positions

. ~/.config/fyre/fyrerc

usage() {
    printf '%s\n' "usage $(basename $0) <mid|lft|rht|full|ext|vid> (wid)"
    exit 1
}

case $2 in
    0x*) PFW=$2 ;;
esac

case $1 in
    res)
        SW=$((SW - 2*XGAP))
        SH=$((SH - TGAP - BGAP))
        W=$((SW/4 - 2*BW))
        H=$((SH/4 - BW - 1))
        if [ $W -lt $minW ] || [ $H -lt $minH ]; then
            W=$minW
            H=$minH
        fi
        ;;
    mid)
        SW=$((SW - 2*XGAP))
        SH=$((SH - TGAP - BGAP))
        W=$((SW/2 - 2*BW))
        H=$((SH/2 - BW))
        ;;
    lft)
        X=$XGAP
        Y=$TGAP
        SW=$((SW - 2*XGAP))
        SH=$((SH - TGAP - BGAP))
        W=$((SW/2 - 2*BW))
        H=$SH
        ;;
    rht)
        Y=$TGAP
        H=$((SH - TGAP - BGAP))
        SW=$((SW - 2*XGAP))
        W=$(((SW - 2*IGAP - 2*BW)/2))
        X=$((W + XGAP + IGAP + BW))
        ;;
    full)
        SW=$((SW - 2*XGAP - 2*BW))
        SH=$((SH - TGAP - BGAP))
        X=$XGAP; Y=$TGAP
        W=$SW; H=$SH
        ;;
    ext)
        Y=$TGAP
        H=$((SH - TGAP - BGAP))
        ;;
    vid)
        W=$(resolution.sh $PFW | cut -d\  -f 1)
        H=$(resolution.sh $PFW | cut -d\  -f 2)
        ;;
    *) usage ;;
esac

wtp $X $Y $W $H $PFW
