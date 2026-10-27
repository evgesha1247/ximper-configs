#!/bin/bash
# Область → файл + буфер. Минимальная копия оригинального бинда, без редактора
d="$HOME/Изображения/Снимки экрана"
mkdir -p "$d"
f="$d/shot_$(date +%Y%m%d_%H%M%S).png"
LOG="$HOME/.config/hypr/scripts/screenshot.log"

if hyprshot -m region -z --raw > "$f"; then
    echo "$(date +%H:%M:%S) ok" >> "$LOG"
    wl-copy < "$f"
    notify-send -t 2000 -i "$f" "Скриншот" "В буфере и в $f"
else
    echo "$(date +%H:%M:%S) fail (код $?)" >> "$LOG"
    rm -f "$f"
fi
