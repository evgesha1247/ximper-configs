# THEME-PLAN — паспорт проекта токйонайт-темизации

**Версия: 1.4** (2026-10-28)
**Система:** ALT Linux (Ximper), Hyprland, zsh, kitty
**Цель:** единый стиль Tokyonight-Dark (#1a1b26 / #24283b / акценты #bb9af7, #7aa2f7, #9ece6a)

---

## 1. Статус этапов

| Этап | Содержание | Статус |
|---|---|---|
| 1 | Kitty, zsh, starship — токйонайт | закрыт |
| 2 | Wofi — стиль токйонайт | закрыт |
| 3 | Waybar — токйонайт | закрыт |
| 4 | Hyprland — анимации, blur, deco | закрыт |
| 5 | Swaync — стиль + blur + mpris | закрыт |
| 6 | Wlogout, nemo, прочее | закрыт |
| 7 | Hyprlock, hyprsunset, обои | открыт |
| 8 | Установщик install.sh | открыт |

### Детали этапов 5–6

- **swaync:** стиль токйонайт, blur через layerrule (match:namespace),
  ignore_alpha настроен, виджет mpris рабочий (проверено на плеере Firefox).
  Коммит: «swaync: tokyo night theme + blur layers».
- **wlogout:** эвакуирован из /etc в репо как настоящий каталог
  (layout, style.css, icons/). Токйонайт-стиль сохранён
  (цвета #bb9af7/#1a1b26 в style.css подтверждены grep'ом).
  layout.save (бэкап-заготовка Ximper) — снесён через git rm.
- **nemo:** тематирован системной темой — gsettings
  org.gnome.desktop.interface gtk-theme = 'Tokyonight-Dark',
  каталог gtk-3.0 в теме есть. Правок не потребовал.
  ~/.config/gtk-3.0/ содержит только bookmarks — gtk.css не писали.

---

## 2. Журнал git-гигиены (2026-10-28)

**Принципы (правила №1–2):** в репо — настоящий файл, снаружи — ссылка;
коммит перед правками.

### Аудит репозитория

- 85 файлов в репо.
- Секретов нет: единственное срабатывание grep'а
  (cava/shaders/pass_through.vert) — ложное, это шейдер.
- ~/.config/.gitignore ведёт чёрный список (мусор, секреты,
  тяжёлое/бинарное) + доблены: goa-1.0/, procps/, kate/lspclient/,
  ranger/plugins/.

### Эвакуация симлинков из /etc

Было 8 симлинков; 4 эвакуированы в репо как настоящие файлы:

| Симлинк | Было | Стало |
|---|---|---|
| wofi | /etc/ximperdistro/hyprland/wofi | настоящий каталог в репо |
| wlogout | /etc/ximperdistro/hyprland/wlogout | настоящий каталог в репо |
| swappy | /etc/ximperdistro/hyprland/swappy | настоящий каталог в репо |
| hypr/hypridle.conf | /etc/ximperdistro/.../hypridle.conf | настоящий файл в репо |

Метод: rm симлинка -> mkdir/cp -a из /etc -> git add -> commit.
Правки при этом физически жили в /etc (симлинк-дверь), потому
стили не пропали. Оригиналы в /etc нетронуты.

### Остаточные симлинки (осознанно оставлены)

- gtk-4.0/assets, gtk-4.0/gtk.css, gtk-4.0/gtk-dark.css
  -> ~/.themes/Tokyonight-Dark/gtk-4.0/... — цель вне репо;
  установщик создаст их сам (этап 8) либо решим класть тему в репо.
- systemd/user/graphical-session.target.wants/swaync.service
  -> /usr/lib/systemd/user/swaync.service — штатная механика systemd;
  установщику достаточно systemctl --user enable swaync.

### Контрольный тест-клон

git clone ~/.config /tmp/dotfiles-test && diff -rq --exclude=.git ...
Результат: «Только в ~/.config» — btop (кандидат на токйонайт-тему),
nemo (войдёт в репо по мере работы), игнорируемые каталоги.
В клоне wofi/wlogout — настоящие каталоги. Клон чист.

### Что git не переносит (для установщика)

1. Пакеты — нужен packages.txt + epm install $(cat packages.txt).
2. Симлинки в $HOME вне ~/.config (~/.zshrc -> ...) — создаёт установщик.
3. Абсолютные симлинки на /etc/ximperdistro на чистой машине мертвы.
4. Шрифты (JetBrainsMono Nerd Font) — через packages.txt.

---

## 3. Проверка репо при клонировании (методика)

- Уровень 1 — аудит: git status --short; git ls-files | wc -l;
  git ls-files -s | awk '$1 == 120000' (симлинки).
- Уровень 2 — тест-клон: clone в /tmp + diff -rq --exclude=.git.
- Уровень 3 — генеральная репетиция: чистый HOME (тестовый юзер
  или VM с ALT Linux) — оправдана к этапу 8.

---

## 4. Открытые вопросы

- [ ] Кнопка Wi-Fi для buttons-grid — нужен сетевой менеджер (nmtui/connman).
- [ ] Иконки для nemo — сейчас стандартные Adwaita; кандидат: Papirus
      или токйонайт-иконки (отдельный мини-этап, по желанию).
- [ ] Пуш на GitHub + настройка remote.
- [ ] btop: токйонайт-тема (в btop есть готовая) — взять при этапа 8
      или добавить сейчас.
- [ ] Предупреждение nemo: 'border-spacing' is not a valid property name
      (gtk.css:1048 темы Tokyonight-Dark) — безобидно, игнорируем.

---

## 5. План этапа 7

- **hyprlock** — экран блокировки в токйонайте. Сначала посмотреть,
  что есть в Ximper-наборе, потом писать стиль.
- **hyprsunset** — ночной фильтр.
- **Анимация обоев** — swww или аналогичный.

---

## 6. Памятка ассистенту (грабли)

- zsh в интерактивном режиме: '#' не комментарий по умолчанию
  (setopt interactivecomments — по желанию юзера, не критично).
- Симлинки в ~/.config на /etc — ловушка: правки уходят в /etc.
  Проверять: git ls-files -s | awk '$1 == 120000'.
- git ls-files показывает индекс, а не диск — после правки
  на диске нужен git add.
- nemo из терминала не возвращает промпт (живёт как демон) — не баг.
- nemo warnings (theme unknown, cinnamon-desktop-editor) — безобидны.
- Метод проверки стилей: grep по цветам (#bb9af7, #1a1b26).

---

## 7. История версий

- 1.4 — этап 6 закрыт (wlogout, nemo); git-гигиена: аудит 85 файлов,
  эвакуация 4 симлинков из /etc, тест-клон чист; план установщика.
- 1.3 — swaync закрыт (стиль, blur, mpris).
- 1.2 — hyprland анимации/blur; wofi стиль.
- 1.1 — waybar; kitty/zsh/starship.
- 1.0 — старт паспорта.
