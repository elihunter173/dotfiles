---
name: write-pr
description: Write PR
allowed-tools:
- Bash(gh pr create *)
- Bash(git diff *)
- Bash(git log *)
- Bash(git push *)
- Bash(git status *)
---

# Write PR

Create a **draft** PR for the current branch with a title and description.

```bash
gh pr create --draft --head <branch> --title <title> --body <body>
```

## Title

Format: `[TICKET-ID] Short imperative title`

- The description should be concise (<60 chars after the prefix) and say what the PR does, not how.
- Use imperative mood. Example: `[MTS2-2300] Remove cobalt::time module entirely`.
- If you don't know the Jira ticket, use `[NOJIRA]`.

## Description

### PR template

```
!`cat .github/pull_request_template.md 2>/dev/null || cat <<'DEFAULTTEMPLATE'
## Summary

<!-- One short paragraph explaining why this PR exists and what it does. -->
DEFAULTTEMPLATE`
```

Use the template above as the structure for the PR body. Fill in or replace placeholder sections with content derived from the actual changes. Preserve any checklists from the template as-is (don't check boxes unless you're confident the item is satisfied). Add a summary section at the top if the template doesn't already include one.

### Writing rules

- **Summary is "what and why"**.
- Write in a direct, casual tone. No filler phrases like "This PR aims to..." or "In order to improve...".
- Don't repeat yourself.
- Link to specific code when it helps a reviewer verify a claim.
- Do NOT list or count every file touched. Reviewers can see the diff.
- Omit obvious details.
