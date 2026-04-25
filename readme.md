dotfiles
========

Because dotfiles are cool.

    git clone git@github.com:clormor/dotfiles.git && cd dotfiles
    ./setup.sh

## What setup.sh does

`setup.sh` symlinks every file and directory in this repo into your home directory as a dotfile:

| Repo file | Symlinked as |
|-----------|-------------|
| `bashrc` | `~/.bashrc` |
| `gitconfig` | `~/.gitconfig` |
| `gitignore_global` | `~/.gitignore_global` |
| `hooks/` | `~/.hooks/` |
| `vimrc` | `~/.vimrc` |
| ... | ... |

If a file already exists at the destination it is backed up as `.<name>.orig` before the symlink is created.

After symlinking, `setup.sh` runs `chmod +x` on all scripts in `hooks/` to ensure they are executable.

## Managing tokens and secrets

Tokens and secrets should **never** be committed to this repo. Instead, export them from `~/.tokens`:

```bash
# ~/.tokens  (never commit this file)
export GITHUB_TOKEN=ghp_...
export AWS_SECRET_ACCESS_KEY=...
```

`~/.bashrc` automatically sources `~/.tokens` on every new shell, so your tokens are always available.

### Layers of protection against accidental commits

Three mechanisms work together to keep secrets out of git:

1. **`~/.gitignore_global`** — common secret filenames (`.tokens`, `.env`, `.env.local`, `.env.secret`, `.env.production`, `.secrets`, `.netrc`, `.nexus`) are ignored across every repo on your machine.

2. **`~/.hooks/pre-commit`** — a global git pre-commit hook that blocks any commit which stages one of those filenames, regardless of which repo you're in. This hook is installed automatically by `setup.sh` (via the `hooks/` → `~/.hooks` symlink and `core.hooksPath = ~/.hooks` in `gitconfig`). No manual step is required.

3. **`source_if_exists`** in `bashrc` — secrets are sourced from a file outside the repo, so there is nothing sensitive inside the repo to commit in the first place.
