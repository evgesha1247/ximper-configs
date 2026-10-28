# Тема Tokyo Night — паспорт раяса Ximper Hyprland

## Архитектура: только оверлеи, /etc не трогаем
- Hyprland  → ~/.config/hypr/user-theme.conf (source последним)
- kitty     → ~/.config/kitty/tokyonight.conf (include последним)
- waybar    → ~/.config/waybar/themes/tokyonight.css
Палитра: bg #1a1b26, text #c0caf5, accent #7aa2f7, dim #292e42, purple #bb9af7

## Правила
1. Правки только в оверлеи. /etc/ximperdistro — читать, не писать.
2. Перед правкой — коммит в git ~/.config (откат: git checkout -- файл).
3. Hyprland 0.53: новый синтаксис (windowrule { match:class }, layerrule { match:namespace })
4. Полный план этапов 0–7 — в основном диалоге (минимализм без фанатизма).

## Статус
- [x] Этап 2: палитра Tokyo Night (kitty, waybar, курсор rose-pine, GTK)
- [x] Этап 3: gaps/borders/blur/тени/анимации в user-theme.conf
- [x] Этап 0: git-репозиторий ~/.config
- [ ] Этап 4: полупрозрачность waybar + blur, чистка модулей (отложено)
- [ ] Этап 5: kitty padding/шрифт, starship
- [ ] Этап 6: wofi/rofi, wlogout, swaync, nemo
- [ ] Этап 7: hyprlock, hyprsunset, анимация обоев

## Мелочи, которые легко забыть
- background_opacity 0.85 живёт в tokyonight.conf (перекрывает /etc)
- бинд скриншота: SUPER SHIFT S → ~/.config/hypr/scripts/screenshot.sh region
- предыстория: user-theme.conf однажды был удалён и спасён из ~/.zsh_history
