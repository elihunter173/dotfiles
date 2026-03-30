# Write PR

Create a **draft** PR for the current branch with a title and description.

```bash
gh pr create --draft --title "..." --body "..."
```

## Title

Format: `[TICKET-ID] Short imperative description`

- Extract the Jira ticket ID from the branch name (e.g. `eli/MTS2-2300-remove-cobalt-time` -> `MTS2-2300`). Fall back to commit messages, then `NOJIRA`.
- The description should be concise (<60 chars after the prefix) and say what the PR does, not how.
- Use imperative mood. Example: `[MTS2-2300] Remove cobalt::time module entirely`

## Description

### PR template

```
!`cat .github/pull_request_template.md 2>/dev/null || cat <<'DEFAULTTEMPLATE'
## Summary

One short paragraph: what this PR does and why. Link the Jira ticket inline
(e.g. [MTS2-1234](https://datadoghq.atlassian.net/browse/MTS2-1234)) and
mention the broader goal if this is part of a larger effort.
DEFAULTTEMPLATE`
```

Use the template above as the **structure** for the PR body. Fill in or replace placeholder sections with content derived from the actual changes. Preserve any checklists from the template as-is (don't check boxes unless you're confident the item is satisfied). Add a summary section at the top if the template doesn't already include one.

### Writing rules

- **Summary is the "what and why"**, Changes is the "how". Don't repeat yourself.
- Group changes by logical intent, not by file. One heading might touch many files; that's fine.
- Each change heading should be a short phrase describing the action taken (e.g. "Replaced X with Y", "Removed unused Z", "Deleted module W").
- Keep explanations under each heading to 1-3 sentences. If you need to justify a non-obvious decision, this is the place.
- Link to specific code when it helps a reviewer verify a claim.
- Don't list every file touched. Reviewers can see the diff.
- Don't count every file touched. Reviewers can see the diff.
- Write in a direct, casual tone. No filler phrases like "This PR aims to..." or "In order to improve...".
- Omit trivially obvious changes.
