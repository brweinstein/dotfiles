#!/usr/bin/env bash
# sync_dotfiles.sh — auto-commit & push dotfiles on login

DOTFILES_DIR="$HOME/Documents/dotfiles/"

# Files/dirs to sync into the repo before committing
declare -A SOURCES=(
  [".zshrc"]="$HOME/.zshrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
  ["alacritty"]="$HOME/.config/alacritty"
  ["nvim"]="$HOME/.config/nvim"
)

cd "$DOTFILES_DIR" || { echo "dotfiles: repo not found at $DOTFILES_DIR"; return 1; }

# Pull first to stay in sync with any changes from other machines
git pull --rebase --autostash -q

# Copy latest files into the repo
for dest in "${!SOURCES[@]}"; do
  src="${SOURCES[$dest]}"
  if [[ -e "$src" ]]; then
    cp -r "$src" "$DOTFILES_DIR/$dest"
  fi
done

# Commit & push only if something changed
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  git commit -m "dotfiles: auto-sync $(date '+%Y-%m-%d %H:%M')"
  git push -q
  echo "dotfiles: synced"
fi

cd "$HOME"
