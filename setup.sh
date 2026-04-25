#!/bin/bash
#
# setup.sh - Install dotfiles by symlinking them into the home directory.
#
# What this script does:
#   1. For each file/directory in this repo (except setup.sh, readme.md):
#      - Backs up any existing file at the destination (renames it to .<name>.orig)
#      - Creates a symlink: ~/.<name> -> <dotfiles>/<name>
#   2. The hooks/ directory is linked as ~/.hooks, which git uses as the global
#      hooks directory (configured via gitconfig: core.hooksPath = ~/.hooks).
#      The pre-commit hook in hooks/ blocks accidental commits of sensitive files.
#   3. Ensures all scripts in hooks/ are executable.
#
# After running this script:
#   - Store tokens/secrets in ~/.tokens (exported as env vars). This file is
#     sourced automatically by every new shell (via bashrc). Never commit it.
#   - The global gitignore (~/.gitignore_global) will prevent common secret
#     filenames from being staged in any repo on this machine.
#   - The global pre-commit hook provides a final safety net across all repos.

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

# Ensure all hook scripts are executable
if [ -d "$DOTFILES/hooks" ]; then
    chmod +x "$DOTFILES"/hooks/*
    echo "Made hook scripts executable in $DOTFILES/hooks/"
fi
