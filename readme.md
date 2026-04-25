dotfiles
========

Because dotfiles are cool.

    git clone git@github.com:clormor/dotfiles.git && cd dotfiles
    ./setup.sh

### Managing Secrets and Tokens

Sensitive credentials (API tokens, passwords, etc.) should **never** be committed to this repository. Several layers of protection are in place to help prevent this.

#### Sourcing tokens

Create a `~/.tokens` file to store your environment-specific secrets:

```bash
export GITHUB_TOKEN="your-token-here"
export MY_API_KEY="your-key-here"
```

This file is automatically sourced by `.bashrc` (and `.zshrc` via `.bashrc`) on every new shell. Because `~/.tokens` is listed in the global `.gitignore` (`~/.gitignore_global`), git will never track it — even if you run `git add .` inside your home directory.

#### Per-directory secrets with direnv

For project-specific secrets, [direnv](https://direnv.net/) is already configured in `.zshrc`. Create a `.envrc` file in a project directory:

```bash
export PROJECT_API_KEY="project-specific-key"
```

Then run `direnv allow` to activate it for that directory. `.envrc` files can source values from `~/.tokens` so you only store secrets in one place.

#### Global gitignore

`~/.gitignore_global` (sourced from `gitignore_global` in this repo) blocks the following files from being staged in any repository on your machine:

```
.tokens  .env  .env.local  .env.secret  .env.production  .secrets  .netrc  .nexus
```

#### Pre-commit hook

A pre-commit hook in `hooks/pre-commit` is automatically installed as a global git hook via `core.hooksPath = ~/.hooks` in `~/.gitconfig`. It applies to **all** git repositories and will block any commit that attempts to stage one of the protected filenames listed above.

To bypass the hook in exceptional circumstances (use with extreme caution):

```bash
git commit --no-verify
```
