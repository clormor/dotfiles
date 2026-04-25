# dotfiles

Personal configuration files for macOS and Linux, managed via symlinks.

## What's included

| File | Purpose |
|------|---------|
| `bashrc` / `bash_profile` | Bash shell config — aliases, PATH, Java, Homebrew, RVM, rbenv |
| `zshrc` / `zprofile` | Zsh config — sources `.bashrc`, adds NVM and direnv support |
| `vimrc` | Vim config — syntax highlighting, filetype plugins, key mappings |
| `gitconfig` | Git config — rebase-on-pull, LFS, conditional includes for work/macOS |
| `gitconfig-osx` | macOS-specific git config (DiffMerge, GPG signing key) |
| `gitconfig-work` | Work-specific git config (included when inside work directories) |
| `gitignore_global` | Global gitignore rules |
| `brewfile` | Homebrew bundle — formulae and casks for macOS |
| `mkshrc` | MirBSD Korn Shell config |

## Setup

Clone the repo and run the setup script:

```sh
git clone git@github.com:clormor/dotfiles.git && cd dotfiles
./setup.sh
```

The script creates a symlink in `$HOME` for each file (prefixed with `.`), backing up any existing file to `<file>.orig` first.
