## Rust Conventions
- When fixing imports after removing re-exports or refactoring modules, NEVER add new `pub use` re-exports as a shortcut. Always fix each individual import path at the call site.
- Never suppress lints unless the user instructs you to.

## Workflow Rules
- When exploring a codebase to understand something, limit exploration to ~10 tool calls before synthesizing findings. If you need more context, summarize what you know so far and ask the user for direction.
- When creating a PR, keep the description brief and only mention the things that changed and the motivation for the changes.
