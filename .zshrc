# ────────────────────────────────
# Minimal & Modern Zsh Config
# ────────────────────────────────

# Use a simple but clean prompt
setopt PROMPT_SUBST
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f %# '

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history share_history

# Aliases
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias gs='git status'
alias gd='git diff'
alias vim='nvim'
alias xclip='xclip -selection clipboard'

# Path
export PATH="$HOME/.cargo/bin:$PATH"

# Enable completion
autoload -Uz compinit; compinit

# Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Default editor
export EDITOR='nvim'

# Rust environment
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Plugins directory
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR" 2>/dev/null

# Syntax highlighting
if [ -f "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
    source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Autosuggestions
if [ -f "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
    source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
