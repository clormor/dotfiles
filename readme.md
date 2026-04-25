# dotfiles

Personal dotfiles for a macOS/Linux development environment. Running `setup.sh` symlinks each file into your home directory as a hidden file (e.g. `bashrc` → `~/.bashrc`). Any existing file is backed up with an `.orig` extension before being replaced.

## Setup

```bash
git clone git@github.com:clormor/dotfiles.git && cd dotfiles
./setup.sh
```

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
| `mkshrc` | `~/.mkshrc` |
| `vimrc` | `~/.vimrc` |
| `zprofile` | `~/.zprofile` |
| `zshrc` | `~/.zshrc` |
