---
name: implement
description: Plan and implement a Jira ticket end-to-end. Reads the ticket, explores the codebase, writes a plan, implements in verified atomic commits, and creates a draft PR. Use when the user says "implement this ticket", "work on TICKET-123", provides a Jira ticket ID, or asks to implement a feature from a ticket.
---

# Implement Jira Ticket

Plan and implement a Jira ticket with verified atomic commits and a draft PR.

## Arguments

`/implement <TICKET-ID>` — e.g., `/implement MTS2-2314`

If no ticket ID is provided, extract it from the current branch name or ask the user.

## Phase 1: Understand

1. **Read the Jira ticket** using the Atlassian MCP tools (`getJiraIssue` or `search`). Extract:
   - Summary and description
   - Acceptance criteria (if any)
   - Linked tickets or context

2. **Explore the codebase** to find relevant code. Use Grep/Glob/Read to identify:
   - Files that need to change
   - Existing patterns to follow
   - Test infrastructure to use
   - Proto/config/schema files if applicable

Limit exploration to ~10 tool calls. If you need more context, summarize what you know and ask the user.

## Phase 2: Plan

Enter plan mode and write a structured plan covering:

- **Context**: What the ticket asks for and why
- **Branch**: Branch name following `<user>/<ticket-id>-<short-description>`
- **Commits**: Each commit as a logical unit with:
  - What files change and how
  - Key code references (file:line)
- **Verification**: How to verify the changes (which packages to check/test)

Keep the plan concise — focus on what changes, not how Rust syntax works.

Present the plan for user approval before implementing.

## Phase 3: Implement

For each commit in the plan:

1. **Make the changes** — edit/create only the files needed
2. **Verify** — run `cargo check` and `cargo clippy` on affected packages. Run tests if they exist.
3. **Commit** — use `/commit` conventions:
   - Stage specific files (never `git add .`)
   - Message format: `[TICKET-ID] Short imperative description`
   - Include co-author trailer
4. **Push** after each commit

If a check fails, fix it before moving on. Never skip verification.

## Phase 4: PR

After all commits are pushed, create a draft PR:

1. Use the `/write-pr` skill conventions for title and description
2. Create with `gh pr create --draft`
3. Return the PR URL to the user

```bash
gh pr create --draft --title "[TICKET-ID] Short description" --body "$(cat <<'EOF'
## Summary

Brief description linking to [TICKET-ID](https://datadoghq.atlassian.net/browse/TICKET-ID).

## Changes

#### First logical change

What and why.

---

Checklist
---------

- [ ] I have a plan for how to revert, rollback, or disable these changes if things are not working as expected
- [ ] The system degrades gracefully with these changes
- [ ] I have covered bugs with reproducing tests
- [ ] I have benchmarked perf-critical changes

Also see the [development guidelines](https://github.com/DataDog/mp-rs/blob/main/rfcs/20230509_guidelines.md).
EOF
)"
```

## Rules

- Always verify before committing. Never commit code that doesn't compile or lint.
- One logical change per commit. The plan defines the commit boundaries.
- If the plan turns out to be wrong mid-implementation, stop and discuss with the user rather than improvising.
- Don't over-engineer. Only make changes the ticket asks for.
- Follow existing patterns in the codebase — don't introduce new conventions.
