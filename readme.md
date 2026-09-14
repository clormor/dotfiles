# dotfiles

Personal dotfiles for a macOS/Linux development environment. Running `setup.sh` symlinks each file into your home directory as a hidden file (e.g. `bashrc` → `~/.bashrc`). Any existing file at the destination is replaced.

## Setup

```bash
git clone git@github.com:clormor/dotfiles.git && cd dotfiles
./setup.sh
```

`setup.sh` does the following:
1. Symlinks every file in this repo into `$HOME` as a dotfile (e.g. `bashrc` → `~/.bashrc`).
2. Prunes dangling symlinks in `$HOME` that point into a directory named after this repo, prompting per file. That covers links left by renames, deletions, and by the repo having been cloned somewhere else previously.

## Managing tokens and secrets

Secrets (API keys, tokens, passwords) should never be committed to source control.

Store exported environment variables in `~/.tokens`:

```bash
export GITHUB_TOKEN=ghp_...
export AWS_ACCESS_KEY_ID=AKIA...
export AWS_SECRET_ACCESS_KEY=...
```

`bashrc` automatically sources this file on every shell start via:

```bash
source_if_exists "$HOME/.tokens"
```

No manual install step is needed — `setup.sh` handles everything.

