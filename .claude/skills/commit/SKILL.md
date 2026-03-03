---
name: commit
description: Verify, commit, and push changes. Runs cargo check and clippy, then creates a conventional commit. Use when the user says "commit", "commit and push", "save my work", or after completing an implementation phase.
---

# Commit

Verify the current changes compile and lint cleanly, then create a commit and optionally push.

## Workflow

### 1. Verify

Run these checks on the affected packages (not the whole workspace unless the change is cross-cutting):

```bash
# Always
cargo check -p <affected-packages>

# If there are non-trivial logic changes
cargo clippy -p <affected-packages> -- -D warnings

# If there are tests for the changed code
cargo nextest run -p <affected-package> -E "test(<relevant-test>)"
```

If any check fails, fix the issue before committing. Do NOT skip checks or suppress warnings.

### 2. Stage

Stage only the files related to the current change. Never use `git add -A` or `git add .`. Be explicit:

```bash
git add path/to/changed/file.rs path/to/other/file.rs
```

### 3. Commit

Extract the Jira ticket ID from the branch name (e.g., `eli/MTS2-2314-pretty-queryspan` → `MTS2-2314`). If none, use `NOJIRA`.

Write a concise commit message:
- Format: `[TICKET-ID] Short imperative description`
- Under 72 chars for the subject line
- Add a body only if the "why" isn't obvious from the subject
- Always include the co-author trailer

```bash
git commit -m "$(cat <<'EOF'
[MTS2-1234] Add retention_seconds to QuerySpanResponse proto

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"
```

### 4. Push (if requested or if on a PR branch)

```bash
git push
```

If the branch has no upstream, use `git push -u origin <branch>`.

## Rules

- Always verify before committing. Never commit code that doesn't compile.
- One logical change per commit. Don't bundle unrelated changes.
- If a pre-commit hook fails, fix the issue and create a NEW commit (do not amend).
- Never force-push without explicit user approval.
- If the user just says "/commit", default to commit + push if the branch already tracks a remote.
