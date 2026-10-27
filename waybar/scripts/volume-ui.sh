#!/bin/bash

BAR='waybar'
STAMP="${XDG_RUNTIME_DIR:-/tmp}/vol-ui.stamp"
HIDE_AFTER=1
SEGS=80                               # длина дорожки в сегментах

# Цвета полоски — подставьте свои:
ACCENT='#7aa2f7'    # залитая часть
DIM='#292e42'       # «пустая» часть

signal_bar() {
    local pids
    pids=$(pgrep -x "$BAR") || return
    [ -n "$pids" ] || return
    kill -42 $pids   # RTMIN+8 -> перерисовать полоску
}
render_bar() {
    local vol mute filled empty i out=""
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    [ "$mute" = "yes" ] && { echo ""; return; }

    filled=$(( (vol * SEGS + 50) / 100 ))
    empty=$(( SEGS - filled ))

    for (( i = 0; i < filled; i++ )); do
        out+="<span background='$ACCENT'> </span>"
    done
    for (( i = 0; i < empty; i++ )); do
        out+="<span background='$DIM'> </span>"
    done
    echo "$out"
}
case "$1" in
render)
    now=$(date +%s%N); last=$(cat "$STAMP" 2>/dev/null || echo 0)
    if [ "$last" -eq 0 ] || (( (now - last) / 1000000000 >= HIDE_AFTER )); then
        echo ""
    else
        render_bar
    fi
    ;;
daemon)
    echo 0 > "$STAMP"
    LC_ALL=C pactl subscribe | while read -r ev; do
        case "$ev" in
            *change*)
                date +%s%N > "$STAMP"
                signal_bar
                ;;
        esac
    done &
    while sleep 0.3; do
        now=$(date +%s%N); last=$(cat "$STAMP" 2>/dev/null || echo 0)
        [ "$last" -eq 0 ] && continue
        if (( (now - last) / 1000000000 >= HIDE_AFTER )); then
            signal_bar
            echo 0 > "$STAMP"
        fi
    done
    ;;
esac

