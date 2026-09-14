#!/usr/bin/env bash
# setup.sh — symlinks dotfiles into your home directory.
#

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
    if [ -e "$DEST" ] && [ "$( readlink "$DEST" )" != "$SOURCE" ]; then
        mv "$DEST" "$DEST.orig"
    fi
    echo "Linking $SOURCE -> $DEST"
    ln -sf "$SOURCE" "$DEST"
done

echo "Checking for dangling dotfile symlinks in $HOME"
for LINK in "$HOME"/.*; do
    [ -L "$LINK" ] || continue
    [ -e "$LINK" ] && continue
    TARGET=$( readlink "$LINK" )
    case "$TARGET" in
        "$DOTFILES"/*) ;;
        *) continue ;;
    esac
    echo "Dangling: $LINK -> $TARGET"
    rm -i "$LINK"
done
