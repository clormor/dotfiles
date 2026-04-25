# dotfiles

Personal dotfiles for a macOS/Linux development environment. Running `setup.sh` symlinks each file into your home directory as a hidden file (e.g. `bashrc` → `~/.bashrc`). Any existing file is backed up with an `.orig` extension before being replaced.

## Setup

```bash
git clone git@github.com:clormor/dotfiles.git && cd dotfiles
./setup.sh
```

## Files

| File | Symlinked to | Description |
|------|-------------|-------------|
| `bash_profile` | `~/.bash_profile` | Bash login shell entry point |
| `bashrc` | `~/.bashrc` | Shell aliases, PATH setup, Java/Ruby/Python tooling, GPG, Homebrew |
| `brewfile` | `~/.brewfile` | Homebrew bundle — run `brew bundle --global` to install packages |
| `gitconfig` | `~/.gitconfig` | Git settings; conditionally includes work and macOS profiles |
| `gitconfig-gpg` | `~/.gitconfig-gpg` | GPG commit-signing configuration |
| `gitconfig-osx` | `~/.gitconfig-osx` | macOS-specific Git settings |
| `gitconfig-work` | `~/.gitconfig-work` | Work identity and settings |
| `gitignore_global` | `~/.gitignore_global` | Global gitignore patterns |
| `mkshrc` | `~/.mkshrc` | MKsh shell configuration |
| `vimrc` | `~/.vimrc` | Vim settings, key mappings, LaTeX and Markdown support |
| `zprofile` | `~/.zprofile` | Zsh login profile |
| `zshrc` | `~/.zshrc` | Zsh config — sources `.bashrc`, adds direnv, nvm, Ruby |
