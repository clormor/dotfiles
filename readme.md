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


## Shell startup log

Every interactive zsh session appends one line to `~/.local/state/zsh/startup.log` when its first prompt appears, recording how long each startup phase took in milliseconds:

```
2026-10-15T08:48:39 total=88ms zprofile=22 etc_zshrc=5 bashrc=11 mise=24 compinit=14 prompt=13 tty=ttys005 term=iTerm.app load=3.63
```

Each phase covers the time since the previous mark:

| Phase | Covers |
|-------|--------|
| `zprofile` | `/etc/zprofile` and `~/.zprofile` (login shells only) |
| `etc_zshrc` | `/etc/zshrc` |
| `bashrc` | `~/.bashrc`, sourced from `~/.zshrc` |
| `mise` | direnv and mise activation |
| `compinit` | completion setup, including any `~/.zcompdump` rebuild |
| `prompt` | precmd hooks before the first prompt |

`load` is the one-minute load average. Startup lag is often intermittent, so check the log after a slow session to see which phase was responsible:

```bash
sort -t= -k2 -n -r ~/.local/state/zsh/startup.log | head
```

A slow session with a small `total` means the delay happened before zsh started, in the terminal emulator.

The log rotates to `startup.log.1` once it exceeds 100KB, so at most two files exist. Writes run in the background and add no prompt latency. Two environment variables override the defaults:

| Variable | Default |
|----------|---------|
| `ZSH_STARTUP_LOG` | `${XDG_STATE_HOME:-$HOME/.local/state}/zsh/startup.log` |
| `ZSH_STARTUP_LOG_MAX_BYTES` | `102400` |

To time a new phase, call `_startup_mark <name>` after it in `zprofile` or `zshrc`, guarded the same way as the existing marks.
