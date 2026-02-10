# Write PR

Write a PR title and description following the conventions below.

## Title

Format: `[TICKET-ID] Short imperative description`

- Extract the Jira ticket ID from the branch name (e.g. `eli/MTS2-2300-remove-cobalt-time` -> `MTS2-2300`). Fall back to commit messages, then `NOJIRA`.
- The description should be concise (<60 chars after the prefix) and say what the PR does, not how.
- Use imperative mood. Example: `[MTS2-2300] Remove cobalt::time module entirely`

## Description

For complex PRs, write both the summary and changes section.

For simple PRs, only write the summary.

```markdown
## Summary

One short paragraph: what this PR does and why. Link the Jira ticket inline
(e.g. [MTS2-1234](https://datadoghq.atlassian.net/browse/MTS2-1234)) and
mention the broader goal if this is part of a larger effort.

## Changes

#### <First logical change>

Brief explanation of what was done and why. If helpful, link to specific code
or reference the old behavior to give reviewers context.

#### <Second logical change>

Same format. Each heading should be a self-contained change that a reviewer
can understand independently.

#### <Third logical change, etc.>

Continue as needed.
```

## Rules

- **Summary is the "what and why"**, Changes is the "how". Don't repeat yourself.
- Group changes by logical intent, not by file. One heading might touch many files; that's fine.
- Each change heading should be a short phrase describing the action taken (e.g. "Replaced X with Y", "Removed unused Z", "Deleted module W").
- Keep explanations under each heading to 1-3 sentences. If you need to justify a non-obvious decision, this is the place.
- Link to specific code when it helps a reviewer verify a claim (e.g. "these two implementations both just call tokio::time::sleep under the hood").
- Don't list every file touched. Reviewers can see the diff.
- Don't count every file touched. Reviewers can see the diff.
- Write in a direct, casual tone. No filler phrases like "This PR aims to..." or "In order to improve...".
- If a change is trivially obvious from the heading, the explanation can be a single short sentence or omitted.
