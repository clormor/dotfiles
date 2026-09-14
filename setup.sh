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
    echo "Linking $SOURCE -> $DEST"
    ln -sf "$SOURCE" "$DEST"
done

# Dangling links left by renames, deletions, or by the repo being cloned
# somewhere new are matched on the repo directory name rather than its full
# path, so links pointing at a previous clone location are still pruned.
REPO_NAME=$( basename "$DOTFILES" )
echo "Checking for dangling dotfile symlinks in $HOME"
for LINK in "$HOME"/.*; do
    [ -L "$LINK" ] || continue
    [ -e "$LINK" ] && continue
    TARGET=$( readlink "$LINK" )
    [ "$( basename "$( dirname "$TARGET" )" )" == "$REPO_NAME" ] || continue
    echo "Dangling: $LINK -> $TARGET"
    rm -i "$LINK"
done
