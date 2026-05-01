## Git Lifecycle
- Use `/do` for the full lifecycle: plan, branch, implement in verified atomic commits, and open a draft PR.
- Use `/mkbranch`, `/commit`, and `/mkpr` individually when needed.

## Rust Conventions
- When fixing imports after removing re-exports or refactoring modules, NEVER add new `pub use` re-exports as a shortcut. Always fix each individual import path at the call site.
- Never suppress lints unless the user instructs you to.
# User-Level Instructions

## Version Control: Always Use jj (Jujutsu)

**IMPORTANT:** Always use `jj` instead of `git` for all version control operations. This applies to every repository and every task.

### Key mappings:
- `git status` → `jj status`
- `git diff` → `jj diff`
- `git log` → `jj log`
- `git add` + `git commit` → `jj commit -m "message"` (jj auto-tracks files, no staging needed)
- `git commit --amend` → `jj describe -m "message"` (to update the current change's description)
- `git push` → `jj git push`
- `git pull` / `git fetch` → `jj git fetch`
- `git branch` → `jj bookmark`
- `git checkout` / `git switch` → `jj new <revision>` or `jj edit <revision>`
- `git rebase` → `jj rebase`
- `git stash` → not needed (jj working copy is always a change)

### Rules:
- Never run raw `git` commands. Always use the `jj` equivalent.
- When creating commits, use `jj commit -m "message"` or `jj describe` + `jj new`.
- When pushing, use `jj git push`.
- When checking repo state, use `jj status`, `jj log`, and `jj diff`.
- For branch/bookmark operations, use `jj bookmark`.
