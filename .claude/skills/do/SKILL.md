---
name: do
description: Plan and execute a task end-to-end with atomic commits and a draft PR. Breaks work into phases, creates a branch, implements each phase with verification, and opens a PR. Use when the user describes a task they want fully implemented, says "do this", "build this", "make this happen", or wants the full git lifecycle for a change.
---

# Do

Plan and execute a task end-to-end: plan, branch, implement in verified atomic commits, and open a draft PR.

## Arguments

`/do <description of work>` — e.g., `/do add on-caller pinging to infra conductors`

If no description is provided, ask the user what they want done.

## Phase 1: Plan

Explore the codebase to understand what needs to change, then enter plan mode.

Write a plan covering:

- **Goal**: What we're doing and why (1-2 sentences)
- **Branch name**: Following `eli/<short-description>` convention
- **Commits**: Each commit as an atomic unit with:
  - Short description of the logical change
  - Which files change
  - How to verify (which packages to check/test, or "config-only" if no Rust)

Keep the plan concise. Present it for user approval before proceeding.

## Phase 2: Branch

Use `/mkbranch` to create and switch to the branch from the plan.

## Phase 3: Implement

For each commit in the plan, run this loop:

1. **Change** — make the edits for this commit
2. **Verify** — confirm the change works (cargo check/clippy/test for Rust, or visual inspection for config-only changes)
3. **Commit** — use `/commit` to stage, commit, and push

Do not move to the next commit until the current one is verified and pushed.

If verification fails, fix the issue before committing. If the plan turns out to be wrong mid-implementation, stop and discuss with the user.

## Phase 4: PR

After all commits are pushed, use `/mkpr` to create a draft PR.

Return the PR URL to the user.

## Rules

- Always verify before committing. Never commit broken code.
- One logical change per commit, as defined by the plan.
- Delegate to `/mkbranch`, `/commit`, and `/mkpr` — don't inline their logic.
- Don't over-engineer. Only make changes the task requires.
- Follow existing patterns in the codebase.
