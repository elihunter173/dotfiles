# Implement Jira Ticket
1. Read the Jira ticket using `jira issue view <ticket>`
2. Create a branch: `git switch -c <user>/<ticket-id>-<short-description>`
3. Implement the changes with atomic commits
4. Run `cargo check` and `just check` after each change
5. Create a draft PR using the /mkpr format

Rules:
- Limit planning to ONE iteration, then implement
- Commit messages under 72 chars
