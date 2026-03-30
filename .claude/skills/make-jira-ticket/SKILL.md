---
name: create-jira-ticket
description: Create a Jira ticket using the jira CLI. Use when the user asks to "create a ticket", "file a jira", "make a jira ticket", "open an issue in jira", or similar.
---

# Create Jira Ticket

Create a Jira ticket using the `jira` CLI.

## Gather Information

Ask the user for any missing details before creating the ticket. Required:
- **Summary**: A short title for the ticket
- **Type**: Task, Bug, Story, etc. Default to Task if not specified.

Optional (only ask if the user hasn't provided them and they seem relevant):
- **Project**: Use `-p PROJECT` to override the default. Only ask if the user mentions a non-default project.
- **Priority**: High, Medium, Low, etc.
- **Description**: A longer body. If the user gave enough context in the summary, skip this.
- **Labels**: Any labels to apply.
- **Epic**: An epic to link the ticket to.

## Create the Ticket

```bash
jira issue create -t <type> -s "<summary>" --no-input
# With optional fields:
jira issue create -t <type> -s "<summary>" -b "<description>" -y <priority> -l <label> --no-input
```

Always use `--no-input` to avoid interactive prompts.

## After Creation

1. Show the user the ticket key and a link to it.
2. If the user mentioned assigning it to someone:
   ```bash
   jira issue assign <KEY> "<assignee>"
   ```
3. If the user mentioned adding it to an epic:
   ```bash
   jira epic add <EPIC-KEY> <KEY>
   ```
4. If the user mentioned a sprint:
   ```bash
   jira sprint add <SPRINT_ID> <KEY>
   ```
