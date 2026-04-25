# dotfiles

Personal dotfiles for a macOS/Linux development environment. Running `setup.sh` symlinks each file into your home directory as a hidden file (e.g. `bashrc` → `~/.bashrc`). Any existing file is backed up with an `.orig` extension before being replaced.

## Setup

```bash
git clone git@github.com:clormor/dotfiles.git && cd dotfiles
./setup.sh
```

`setup.sh` does the following:
1. Symlinks every file in this repo into `$HOME` as a dotfile (e.g. `bashrc` → `~/.bashrc`). Any existing file is first backed up as `.orig`.
2. Symlinks `hooks/` to `~/.hooks` and marks all hook scripts executable.

## Files

| File | Symlinked to |
|------|-------------|
| `bash_profile` | `~/.bash_profile` |
| `bashrc` | `~/.bashrc` |
| `brewfile` | `~/.brewfile` |
| `gitconfig` | `~/.gitconfig` |
| `gitconfig-gpg` | `~/.gitconfig-gpg` |
| `gitconfig-osx` | `~/.gitconfig-osx` |
| `gitconfig-work` | `~/.gitconfig-work` |
| `gitignore_global` | `~/.gitignore_global` |
| `hooks/` | `~/.hooks/` |
| `mkshrc` | `~/.mkshrc` |
| `vimrc` | `~/.vimrc` |
| `zprofile` | `~/.zprofile` |
| `zshrc` | `~/.zshrc` |

## Managing tokens and secrets

Secrets (API keys, tokens, passwords) should never be committed to source control. This repo provides three layers of protection.

### Layer 1 — `~/.tokens`

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

`~/.tokens` is listed in `gitignore_global` so it can never be accidentally staged.

### Layer 2 — global gitignore

`gitignore_global` (symlinked to `~/.gitignore_global` and referenced by `gitconfig`) prevents the following filenames from being staged in **any** repo on your machine:

```
.tokens  .env  .env.local  .env.secret  .env.production  .secrets  .netrc  .nexus
```

### Layer 3 — global pre-commit hook

`hooks/pre-commit` (symlinked to `~/.hooks/pre-commit`) runs before every commit across all repos. It refuses the commit if any of the protected filenames above are staged, printing a clear error and the command to unstage the file.

`gitconfig` tells git to use `~/.hooks` as the global hooks directory:

```ini
[core]
    hooksPath = ~/.hooks
```

No manual install step is needed — `setup.sh` handles everything.
