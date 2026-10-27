### - - -  S E T T I N G - OH-MY-ZSG - - - ###

# ПЕРЕМЕННЫЕ СРЕДЫ  Path installation.
	# export ZSH="$HOME/.oh-my-zsh"

# THEME ТЕМЫ: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
	# ZSH_THEME="robbyrussell"

# HISTORI ИСТОРИЯ КОМАНД MAX/MIN
	export HISTSIZE=100000
	export SAVEHIST=100000

# PLAGINS РАСШИРЕНИЯ plugins.
	plugins=(
		git
		colored-man-pages
		composer
		zsh-syntax-highlighting 
		zsh-autosuggestions 
	)
alias -g  nano='nano --zap '
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -la --icons=auto --group-directories-first --git'
alias lt='eza -T --icons=auto --level=2'
# свежее сверху:
alias la='eza -la --icons=auto --group-directories-first --sort=modified --reverse'
alias lnew='eza -1 --icons=auto --sort=modified --reverse | head'
# source $ZSH/oh-my-zsh.sh

export "MICRO_TRUECOLOR=1"
export PATH="$HOME/.local/bin:$PATH"



# --- переключатель промпта: oh-my-zsh / starship ---
if [[ -r ~/.config/prompt-mode ]] && grep -q starship ~/.config/prompt-mode; then
    eval "$(starship init zsh)"
else
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="robbyrussell"
    source $ZSH/oh-my-zsh.sh
fi

prompt() {
    case "$1" in
        starship) echo "starship" > ~/.config/prompt-mode ;;
        omz)      echo "omz"      > ~/.config/prompt-mode ;;
        *) echo "использование: prompt starship | omz   (затем: exec zsh)" ;;
    esac
}


eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# --- подсветка синтаксиса и подсказки (всегда последними) ---
source /usr/share/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- меню автодополнения: стрелки, подсветка выбора ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}" \
  "di=38;2;122;162;227" \
  "ma=48;2;41;57;79;38;2;219;227;255"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format ''

# --- стрелки: поиск по истории с учётом уже набранного префикса ---
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# --- подсветка в Tokyo Night ---
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'
#ZSH_HIGHLIGHT_STYLES[builtin]='fg=#bb9af7'
#ZSH_HIGHLIGHT_STYLES[alias]='fg=#7dcfff'
#ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#e0af68'
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'
#ZSH_HIGHLIGHT_STYLES[option]='fg=#bb9af7'
#ZSH_HIGHLIGHT_STYLES[comment]='fg=#565f89'
