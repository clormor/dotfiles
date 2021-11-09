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

