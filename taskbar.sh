#!/bin/sh
#
# wildefyr - 2016 (c) MIT
# report group and window title data in lemonbar format

. fyrerc.sh

# colours!!11!!!
ACTIVE="%{F#D7D7D7}"
INACTIVE="%{F#737373}"

for group in $GROUPSDIR/group.?; do
    title=""
    numGroups=$(find $GROUPSDIR/group.? 2> /dev/null | wc -l)
    groupNum=$(printf "$group" | rev | cut -d'.' -f 1 | rev)

    colour="$INACTIVE"

    while read -r groupId; do
        test "$groupId" -eq "$groupNum" && {
            colour="$ACTIVE"
            break
        } || {
            colour="$INACTIVE"
        }
    done < $GROUPSDIR/active

    wids=$(tr '\n' ' ' < $group)

    for wid in $wids; do
        window="$(class ${wid})"
        case "$window" in
            "URxvt")
                window="$(name ${wid})"
                case "$window" in
                    "urxvt")
                        window="$(wname ${wid})"
                        ;;
                    "tmux")
                        window="$(wname ${wid})"
                        ;;
                    "ssh")
                        window="ssh: $(ps $(process $wid) | tail -1 | awk '{printf $NF}')"
                        ;;
                    "mosh")
                        window="mosh: $(ps $(process $wid) | tail -1 | awk '{printf $NF}')"
                        ;;
                esac
                ;;
            "mpv")
                window="$(wname ${wid}) - $(resolution ${wid} | cut -d\  -f 2)p"
                ;;
            "wine")
                window="$(wname ${wid})"
                ;;
            "google-chrome")
                window="chrome"
                ;;
        esac

        test -z "$title" && {
            title="$(printf "$window" | tr '\n' ' ')"
        } || {
            title="${title} \ $(printf "$window" | tr '\n' ' ')"
        }
    done

    test ! -z "$title" && {
        stringOut="${stringOut}${colour}\
%{A1:windows.sh -T $groupNum:}\
%{A3:windows.sh -h $groupNum:}\
  ${title}  \
%{A}%{A}"
    } || {
        continue
    }

    counter=$((counter + 1))
    test "$counter" -ne "$numGroups" && {
        stringOut="${stringOut}${INACTIVE}|"
    }
done

printf '%s\n' "${stringOut}"
