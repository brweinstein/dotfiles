# ─ Gruvbox Dark Colors ───────────────────
# bg0:   #282828
# bg1:   #3c3836
# fg:    #ebdbb2
# gray:  #928374
# blue:  #83a598
# aqua:  #8ec07c
# yellow:#fabd2f
# red:   #fb4934

# ─ Prompt ────────────────────────────────
setopt PROMPT_SUBST

# Minimal prompt (tmux handles context)
PROMPT='%F{#928374}%n%f %F{#83a598}❯%f '

# ─ History ───────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history share_history inc_append_history

# ─ Completion ────────────────────────────
autoload -Uz compinit; compinit

# ─ Aliases ───────────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -lah --icons --group-directories-first'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias nv='nvim'
alias xclip='xclip -selection clipboard'
alias q='exit'

# ─ Path ──────────────────────────────────
export PATH="$HOME/.cargo/bin:$PATH"

# Autosync dotfiles
[[ -o login ]] && source ~/Documents/dotfiles/sync_dotfiles.sh

# ─ Environment ───────────────────────────
export EDITOR='nvim'
export CLICOLOR=1

# ─ Rust ──────────────────────────────────
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ─ NVM ───────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]             && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ]    && source "$NVM_DIR/bash_completion"

# ─ Tmux: refresh status bar on cd ────────
chpwd() {
    [[ -n "$TMUX" ]] && tmux refresh-client -S
}

# ─ Plugins ───────────────────────────────
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR" 2>/dev/null

_load_plugin() {
    local repo="$1" name="${1##*/}"
    local path="$ZSH_PLUGIN_DIR/$name/$name.zsh"
    if [[ ! -f "$path" ]]; then
        git clone "https://github.com/$repo.git" "$ZSH_PLUGIN_DIR/$name"
    fi
    source "$path"
}

_load_plugin zsh-users/zsh-syntax-highlighting
_load_plugin zsh-users/zsh-autosuggestions

# ─ Plugin colors (Gruvbox) ────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[command]='fg=#83a598'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[function]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#928374'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#fb4934'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#8ec07c'
