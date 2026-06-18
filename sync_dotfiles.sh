#!/usr/bin/env bash
# sync_dotfiles.sh — auto-commit & push dotfiles on login

DOTFILES_DIR="$HOME/Documents/dotfiles/"

declare -A SOURCES=(
  [".zshrc"]="$HOME/.zshrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
  ["alacritty"]="$HOME/.config/alacritty"
  ["nvim"]="$HOME/.config/nvim"
)

cd "$DOTFILES_DIR" || { echo "dotfiles: repo not found at $DOTFILES_DIR"; exit 1; }

git pull --rebase --autostash -q

for dest in "${!SOURCES[@]}"; do
  src="${SOURCES[$dest]}"
  if [[ -e "$src" ]]; then
    cp -r "$src" "$DOTFILES_DIR/$dest"
  fi
done

if [[ -n $(git status --porcelain) ]]; then
  git add -A
  git commit -m "dotfiles: auto-sync $(date '+%Y-%m-%d %H:%M')"
  git push origin master -q
  echo "dotfiles: synced"
fi

cd "$HOME"
