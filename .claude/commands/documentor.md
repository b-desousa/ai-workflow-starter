---
description: Adopt an existing project into the ai-workflow-starter memory structure. Reads the codebase, generates or enriches docs/, commits before and after. No code changes.
---

# /documentor

You are about to document an existing project. No code will be modified. The only output is a structured `docs/` memory layer that future Claude Code sessions can use.

## What this command does

1. **Snapshot commit** — saves current state before any change (guaranteed restore point)
2. **Fetches the template reference** — reads the latest ai-workflow-starter structure at runtime
3. **Explores the codebase** — reads all source files, configs, existing docs, git history
4. **Generates or enriches `docs/`** — project.md, architecture.md, ADRs, session-notes.md
5. **Final commit** — seals the new memory layer

## Constraints

- Never modifies code, tests, or config files
- If `docs/` already exists, enriches it — never overwrites correct content
- Marks uncertain inferences as `[TO FILL]` rather than hallucinating
- Both commits are mandatory — do not skip either one

## Dispatch

Use the `documentor` agent:

```
Task(
  agent="documentor",
  model="claude-sonnet-4-5",
  prompt="Adopt this project: read the full codebase, generate the docs/ memory layer, commit before and after."
)
```

## After completion

Review the `[TO FILL]` items printed in the summary and fill them manually or via a follow-up `/feature` brief.

The project is now ready for the standard workflow:
```
/feature [brief]
/session-close
```
