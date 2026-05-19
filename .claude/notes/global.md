# Project Learnings

### [2026-05-19] Git includeIf directive ordering

**Context**: Adding a gitconfig-foundry file with an email override, wired up via includeIf.
**Correction**: The includeIf was placed at the top of gitconfig, before the [user] block. The foundry email was not taking effect because git uses the last value for a key, so the default [user] email overrode it.
**Rule**: Any includeIf directive that overrides a default value must appear after the section containing that default in the file.
**Applies to**: gitconfig / any git config layering work
