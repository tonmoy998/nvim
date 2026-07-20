#!/usr/bin/env bash

file="$1"

# Clear preview area
kitty +kitten icat --clear

# Detect image
if file --mime-type "$file" | grep -q image/; then
  kitty +kitten icat \
    --transfer-mode=stream \
    --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" \
    "$file"
else
  bat --style=plain --color=always "$file" 2>/dev/null ||
    sed -n '1,200p' "$file"
fi
