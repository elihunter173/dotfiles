## Workflow Rules
- Use `/mkbranch` for making git branches.
- Use `/commit` for making git commits.
- Use `/write-pr` for making PRs.
- When exploring a codebase to understand something, limit exploration to ~10 tool calls before synthesizing findings. If you need more context, summarize what you know so far and ask the user for direction.

## Rust Conventions
- When fixing imports after removing re-exports or refactoring modules, NEVER add new `pub use` re-exports as a shortcut. Always fix each individual import path at the call site.
- Never suppress lints unless the user instructs you to.

## Jira CLI (`jira`)
The `jira` CLI (https://github.com/ankitpokhrel/jira-cli) is installed and configured. Config is at `~/.config/.jira/.config.yml`. Use `-p PROJECT` to override the default project. Always use `--plain` and/or `--no-input` flags to avoid interactive prompts.

### Common Commands

**View an issue:**
```bash
jira issue view ISSUE-KEY
jira issue view ISSUE-KEY --comments 5   # show more comments
jira issue view ISSUE-KEY --raw           # raw JSON
```

**List issues:**
```bash
jira issue list --plain                          # plain table output
jira issue list -a "user@example.com" --plain    # by assignee
jira issue list -s "In Progress" --plain         # by status
jira issue list -t Bug -y High --plain           # by type and priority
jira issue list -l backend --plain               # by label
jira issue list -q "JQL query" --plain           # raw JQL
jira issue list --plain --columns key,status,summary,assignee  # specific columns
jira issue list --paginate 20 --plain            # limit results
```

**Create an issue:**
```bash
jira issue create -t Task -s "Summary" -b "Description" --no-input
jira issue create -t Bug -s "Bug title" -y High -l bug --no-input
jira issue create -p PROJECT -t Story -s "Title" --no-input
```

**Edit an issue:**
```bash
jira issue edit ISSUE-KEY -s "New summary" --no-input
jira issue edit ISSUE-KEY -b "New description" --no-input
jira issue edit ISSUE-KEY -y High -l newlabel --no-input
jira issue edit ISSUE-KEY --label -oldlabel --no-input   # remove label with -
```

**Transition (move) an issue:**
```bash
jira issue move ISSUE-KEY "In Progress"
jira issue move ISSUE-KEY Done
```

**Assign an issue:**
```bash
jira issue assign ISSUE-KEY "user@example.com"
jira issue assign ISSUE-KEY $(jira me)     # assign to self
jira issue assign ISSUE-KEY x              # unassign
```

**Comment on an issue:**
```bash
jira issue comment add ISSUE-KEY "Comment text"
```

**Open in browser:**
```bash
jira open ISSUE-KEY
```

**Sprints and Epics:**
```bash
jira sprint list --plain
jira sprint add SPRINT_ID ISSUE-KEY
jira epic list --plain
jira epic create -n "Epic name" -s "Summary" --no-input
jira epic add EPIC-KEY ISSUE-KEY
```

**Current user:**
```bash
jira me
```
