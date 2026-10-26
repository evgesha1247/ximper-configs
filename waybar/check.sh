cd ~/.config/waybar || exit 1
for f in config.jsonc modules/*.jsonc; do
    # вычленяем ключи верхнего уровня (строки вида "name": )
    grep -oP '^\s{4}"[^"]+"\s*:' "$f" | tr -d ' ":' |
    while read -r key; do
        grep -rl "\"$key\"" config.jsonc modules/*.jsonc | grep -v "$f" | while read -r other; do
            echo "ДУБЛЬ: '$key' есть в $f и $other"
        done
    done
done
