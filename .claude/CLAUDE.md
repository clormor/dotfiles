# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for a macOS/Linux development environment. `setup.sh` symlinks every file at the repo root into `$HOME` as a hidden file (e.g. `bashrc` → `~/.bashrc`). Files named `readme.md` and `setup.sh` are skipped. Any existing destination file is backed up with an `.orig` suffix before being replaced.

## Applying changes

```bash
./setup.sh
```

That is the only "build" step. There are no tests, no linter, and no CI validation beyond the GitHub Actions workflows.

## File naming convention

Files at the repo root are stored without the leading dot. `setup.sh` prepends it on symlink creation. New dotfiles follow the same convention: add `newfile`, not `.newfile`.

## Secrets and tokens

`bashrc` sources `~/.tokens` on every shell start via `source_if_exists "$HOME/.tokens"`. Exported environment variables (API keys, tokens, passwords) go there and are never committed.

## Git config layering

`gitconfig` uses `includeIf` to compose config conditionally:

- `~/.gitconfig-osx` and `~/.gitconfig-gpg` apply for repos under `/Users/` (macOS paths).
- `~/.gitconfig-work` applies for repos under `work/` or the Coder remote path.
- GPG commit signing (`gpgsign = true`) is enabled via `gitconfig-gpg` on macOS. The signing key is defined in `gitconfig-osx`.

## GitHub Actions

Two workflows run on PRs:

- `claude.yml` — responds to `@claude` mentions in issues and PR comments using `anthropics/claude-code-action`. Commits are SSH-signed via `CLAUDE_SSH_SIGNING_KEY`.
- `claude-code-review.yml` — runs an automated `/code-review` on every PR open/sync using the `code-review` plugin.

Both require `ANTHROPIC_API_KEY` to be set as a repository secret.
