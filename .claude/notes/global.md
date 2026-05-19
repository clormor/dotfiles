# Project Learnings

### [2026-05-19] Git includeIf directive ordering

**Context**: Adding a gitconfig-foundry file with an email override, wired up via includeIf.
**Correction**: The includeIf was placed at the top of gitconfig, before the [user] block. The foundry email was not taking effect because git uses the last value for a key, so the default [user] email overrode it.
**Rule**: Any includeIf directive that overrides a default value must appear after the section containing that default in the file.
**Applies to**: gitconfig / any git config layering work

### [2026-05-19] Personal skills must not carry Valliance framing

**Context**: Writing a personal skill (`repo-standardise`) to configure GitHub repos. Framed it around "Valliance standards" and used Valliance identity language throughout.
**Correction**: The skill is personal, not a Valliance deliverable. No Valliance branding, standards references, or identity language.
**Rule**: Before writing a skill, establish whether it is personal or work-facing. Personal skills use neutral, first-person framing with no org identity.
**Applies to**: any skill written for personal use under ~/.claude/skills/

### [2026-05-19] Never pass secret values through Claude or Bash tool commands

**Context**: Designing a skill that sets GitHub repo secrets on the user's behalf. The skill was written to accept the secret value from the user and pass it via `gh secret set --body "$VALUE"`.
**Correction**: The `pre-tool-log.sh` hook logs the full Bash command string before execution. Any secret interpolated into that string ends up in the log. The value also passes through Claude's context window.
**Rule**: Never accept or interpolate secret values into Bash commands. Instead, construct the full command with all non-secret parameters filled in and instruct the user to run it themselves with `!` in the prompt. `gh secret set KEY --repo REPO` without `--body` reads from the terminal interactively, keeping the value out of logs and Claude's context entirely.
**Applies to**: any task or skill that handles API keys, tokens, SSH keys, or any other secret value

### [2026-05-19] Skill permissions belong in allowed-tools frontmatter, not global settings

**Context**: Writing the `personal-repo-setup` skill which needed `gh repo view`, `gh api`, `gh repo edit`, and `gh secret list` to run without prompts. Added these to `~/.claude/settings.json` globally.
**Correction**: Skill-level permissions should be declared in the skill's own `allowed-tools` frontmatter field, scoping them to that skill only. Global settings should not be widened for skill-specific needs.
**Rule**: When a skill needs tool permissions, declare them in the SKILL.md frontmatter: `allowed-tools: Bash(gh api *) Bash(gh repo view*)`. Reserve global settings for permissions that genuinely apply everywhere.
**Applies to**: any skill written under ~/.claude/skills/

### [2026-05-19] Skill file templates belong in separate files, not inlined in SKILL.md

**Context**: Writing a skill that deploys GitHub Actions workflow YAML to target repos. Embedded the full YAML content directly inside SKILL.md.
**Correction**: Templates that the user may want to tweak over time should live as separate files in the skill directory (e.g. `templates/claude.yml`). SKILL.md instructs Claude to read and copy them.
**Rule**: Any file a skill writes to a target repo is a template. Put it in the skill directory as a standalone file so it can be edited independently of the skill logic.
**Applies to**: any skill that writes files into a target repo
