---
allowed-tools: Read, Write
description: End-of-session wrap-up — updates session-notes.md Active section and archives to History.
---

Close out the current working session by updating `docs/journal/session-notes.md`.

## Step 1 — Collect session data

Before writing anything, gather:
- What was done (max 5 bullets, commit-style)
- What is still pending or unresolved
- Any decisions made (link ADR if one was created)
- The single next concrete action

## Step 2 — Archive previous Active state to History

Move the current `### Last session` block from `## Active` into `## History` as a one-line table row:

```
| YYYY-MM-DD | [TYPE] short summary of what was done |
```

Insert it at the top of the History table (newest first).

## Step 3 — Rewrite the Active section

Replace `## Active` with the current state. Keep it under 30 lines total.

```markdown
## Active

### Project state
[One-line summary of where the project stands now]

### Stack
[Stack line — unchanged if nothing changed]

### Last session

**Date:** YYYY-MM-DD  
**Duration:** ~X min  
**Focus:** [What was the main goal?]

#### Done
- [FEAT/FIX/...]: ...
- ...

#### Left open / TODO
- ...

### Pending decisions
- [Any unresolved architecture or design choices]

### Known issues
- [Bugs or tech debt worth surfacing immediately next session]
```

## Step 4 — Commit

```
[DOCS]: session close YYYY-MM-DD
```

Do not ask for confirmation. Write and commit silently.
