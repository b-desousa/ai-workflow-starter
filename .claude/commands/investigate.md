---
description: Investigate an architecture question, map dependencies, or prepare an ADR. Provide a clear question or topic about the codebase.
---

# /investigate

You are about to perform a read-only architectural investigation. No files will be modified. Your job is to explore broadly and return a structured report.

## Step 1 — Dispatch architecture-investigator

Use the `architecture-investigator` agent with the question provided by the human.

Load for context before dispatching:
- `@docs/architecture.md` if it exists
- `@docs/project.md` if it exists

## Step 2 — Return structured report

Present the output in this exact format:

```
## Investigation: <topic>

### Answer
<concise answer to the question>

### Impacted files
- `path/to/file.ext` — reason
- ...

### Open questions & risks
- ...

### Draft ADR
> Only include if the investigation reveals a decision to be made.
> Use the template from `docs/decisions/` if it exists.
```

## Principles

- Read broadly, summarize tightly.
- Never modify files — investigation only.
- If uncertain, say so explicitly.
- If the scope is too large for one pass, say so and suggest how to split the question.
