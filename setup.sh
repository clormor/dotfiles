#!/usr/bin/env bash
# setup.sh — symlinks dotfiles into your home directory.
#
# What this script does:
#   1. Symlinks each file in this repo into $HOME as a hidden file
#      (e.g. bashrc -> ~/.bashrc). Existing files are backed up as .orig.
#   2. Symlinks the hooks/ directory to ~/.hooks and makes all hook
#      scripts executable so that git picks them up globally.

SCRIPT_NAME=$(basename $0)
DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "Installing dotfiles from $DOTFILES"
for FILE in `ls $DOTFILES`; do
    if [ "$FILE" == "$SCRIPT_NAME" ] || [ "$FILE" == "readme.md" ] ; then
        echo "Skipping $FILE"
        continue
    fi
    SOURCE="$DOTFILES/$FILE"
    DEST="$HOME/.$( basename $FILE )"
    if [ -e "$DEST" ]; then
        mv "$DEST" "$DEST.orig"
    fi
    echo "Linking $SOURCE -> $DEST"
    ln -sf "$SOURCE" "$DEST"
done

# make all hook scripts executable
if [ -d "$HOME/.hooks" ]; then
    chmod +x "$HOME/.hooks/"*
fi
