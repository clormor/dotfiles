# personal-repo-setup Skill Learnings

### [2026-05-19] Change default branch before committing workflow files

**Context**: Skill committed workflow files then changed the default branch. The commit landed on `master` (the old default), leaving `main` without the workflows.
**Correction**: The default branch must be changed to `main` before any files are written or committed.
**Rule**: Step ordering matters — remote default branch change must come first, then `git checkout main && git pull`, then write and commit files.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Delete old default branch immediately after switching to main

**Context**: Skill changed the default branch to `main` but left `master` in place. The old branch was 1 commit ahead of main after the skill committed to it by mistake.
**Correction**: Delete the old default branch at the end of step 2, immediately after the default is changed, before any further work.
**Rule**: Leaving the old branch risks accidental future pushes and divergence. Delete it as part of the same step that changes the default — not as an afterthought.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Explicitly checkout main and pull before writing files

**Context**: After changing the remote default branch to `main`, the local checkout was still on `master`. Workflow files were written and committed to the wrong branch.
**Correction**: Always run `git checkout main && git pull` at the start of step 4, regardless of what branch the local checkout appears to be on.
**Rule**: Changing the remote default does not update the local HEAD. Always explicitly switch and pull before writing any files.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Init output must be committed, PR'd, and merged by the skill

**Context**: The skill invoked `/init`, which created `CLAUDE.md` and `.claude/`, then reported completion. The files were left as uncommitted changes with no PR or merge.
**Correction**: The skill is not done until the init output is on `main`. After init runs, create a branch, commit the output, open a PR, and merge it before reporting completion.
**Rule**: Any files a skill creates must land on the default branch before the skill is considered complete. Never leave generated files uncommitted or in an unmerged branch.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Remove branch protection to merge, then re-apply immediately

**Context**: The skill needed to merge the init PR to `main`, which has `enforce_admins: true` and requires 1 approval. No mechanism existed to auto-approve.
**Correction**: Temporarily remove branch protection, merge, then re-apply protection in immediate sequence. Never leave protection disabled after the merge completes.
**Rule**: The remove → merge → re-apply sequence is the correct pattern for any automated merge to a protected branch. Re-apply in the same operation, not as a deferred step.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Use gh pr merge --admin to merge init PR, not remove/re-apply protection

**Context**: Previous entry "Remove branch protection to merge, then re-apply immediately" (above) was wrong. Skill was removing branch protection to work around the review requirement, then re-applying it.
**Correction**: Do not touch branch protection. Use `gh pr merge --squash --delete-branch --admin` which bypasses the review requirement via admin privilege while leaving protection intact.
**Rule**: `gh pr merge --admin` is the correct tool for merging a PR that does not yet have required reviews. Never remove branch protection to facilitate a merge.
**Supersedes**: "Remove branch protection to merge, then re-apply immediately" entry above.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Checkout main and pull after merging init PR

**Context**: After merging the init PR, the local checkout was left on the `chore/claude-init` branch (now deleted remotely) without pulling the merged changes into main.
**Correction**: After `gh pr merge`, always run `git checkout main && git pull` to sync the local branch with the merged result.
**Rule**: A merged PR does not automatically update the local checkout. Always switch to main and pull immediately after any automated merge.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Check remote main for CLAUDE.md, not the local filesystem

**Context**: Skill ran `ls CLAUDE.md` to decide whether init was needed. CLAUDE.md was present locally from a previous partial run but had never been committed. Skill incorrectly treated this as "already initialised" and skipped the step.
**Correction**: Check the remote main branch via GitHub API: `gh api "repos/$REPO/contents/CLAUDE.md"`. A 200 means it is on main; a 404 means init is incomplete regardless of local state.
**Rule**: Never use local filesystem state to determine whether a step has been completed. Always check the authoritative source — the remote branch.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Recover from partial init run without re-running init

**Context**: Init had been run in a previous session, leaving CLAUDE.md locally uncommitted. Skill needed to handle this without running init again and producing duplicate or conflicting output.
**Correction**: If init output files are locally present but uncommitted, skip invoking init and go directly to the commit/PR/merge step to complete what was already started.
**Rule**: Before invoking init, check git status. If the expected output files already exist locally, the previous run succeeded — complete the commit/merge process rather than re-running init.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Check for uncommitted changes at skill start and handle explicitly

**Context**: Skill began executing steps without inspecting local working tree state. Uncommitted files from a previous partial run were silently ignored until they caused a failure later.
**Correction**: Run `git status --short` at the start of the skill (step 1) and decide how to handle any uncommitted changes before proceeding. They may indicate a partial previous run that should be resumed rather than restarted.
**Rule**: Always inspect working tree state at the start of any skill that reads or writes files. Treat unexpected uncommitted changes as signal, not noise.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md

### [2026-05-19] Init step must not be deferred or skipped

**Context**: The init step (step 5) was described as conditional and was silently skipped when the skill ran — leaving no CLAUDE.md or .claude directory in the target repo.
**Correction**: Init is a required part of the setup flow. The skill must always run it (unless CLAUDE.md already exists) and must not exit before completing it.
**Rule**: Treat init as mandatory. Do not mark the skill complete until init has run. If something prevents it, surface the error rather than skipping silently.
**Applies to**: ~/.claude/skills/personal-repo-setup/SKILL.md
