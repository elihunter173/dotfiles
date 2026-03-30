---
name: mkbranch
description: Create and switch to a new git branch with the format eli/<short-description>. Use when the user asks to "make a branch", "create a branch", "new branch", "start working on", or wants to begin work on a new task.
---

# Make Branch

Create and switch to a new git branch from the default remote branch with the naming format `eli/<short-description-of-work>`.

## Instructions

1. Determine the short description for the branch name:
   - If the user provided a description, convert it to a kebab-case slug (lowercase, hyphens, no special characters)
   - If the user provided a Jira ticket (e.g., HIS-1234), include it: `eli/HIS-1234-short-description`
   - If no description was given, ask the user what the branch is for

2. Detect the default remote branch, fetch, and create the branch:
   ```bash
   default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's|refs/remotes/origin/||')
   git fetch origin "$default_branch"
   git checkout -b eli/<short-description> "origin/$default_branch"
   ```

4. Confirm the branch was created and switched to.
