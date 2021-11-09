SCRIPT_NAME=$(basename $0)
DOTFILES=$HOME/.dotfiles
echo "Installing dotfiles from $DOTFILES"
for FILE in `ls -A $DOTFILES`; do
    SOURCE="$DOTFILES/$FILE"
    DEST="$HOME/$( basename $FILE )"
    if [ -e "$DEST" ]; then
        mv "$DEST" "$DEST.orig"
    fi
    if [ "$FILE" == "$SCRIPT_NAME" ]; then
        echo "Skipping $FILE"
        continue
    fi
    echo "Linking $SOURCE -> $DEST"
    ln -s "$SOURCE" "$DEST"
done

