---
description: Initialize a new project from a filled project brief. Run once after cloning the template. Provide the complete filled brief from docs/prompts/project-brief-template.md.
---

# /project-init

You are initializing a brand-new project from a human-provided brief. This command runs **once**, on a fresh clone of the template. Your job is to translate the brief into structured project documentation, create initial ADRs, and leave the repo ready for the first `/feature`.

## Step 1 — Parse the brief

Read the brief provided by the human. Extract:
- Project name, vision, short-term objective, users
- Features v1 and out-of-scope v1
- Tech stack, infrastructure, external integrations, constraints
- Key decisions (each becomes an ADR)
- Open questions (each becomes an ADR stub with status: proposed)
- Risks and watch points

If the brief is missing critical sections (Vision, Features v1, Stack), ask for them before proceeding. Do not invent them.

## Step 2 — Fill docs/project.md

Write `docs/project.md` with this structure:

```markdown
# [Project name]

## Vision
[from brief]

## Short-term objective
[from brief]

## Users
[from brief]

## Features v1
[from brief — bulleted list]

## Out of scope v1
[from brief — bulleted list]

## Risks & watch points
[from brief]
```

## Step 3 — Fill docs/architecture.md

Write `docs/architecture.md` with this structure:

```markdown
# Architecture — [Project name]

## Stack
[from brief]

## Infrastructure
[from brief]

## External integrations
[from brief]

## Constraints
[from brief]

## Security notes
- Secrets via environment variables only, never in source
- [Add any constraint-derived security notes from brief]
```

## Step 4 — Create ADRs

For each **Key decision** in the brief, create `docs/decisions/ADR-NNN-<slug>.md`:

```markdown
# ADR-NNN: [Decision title]

Date: YYYY-MM-DD  
Status: accepted

## Context
[Why this decision was needed]

## Decision
[What was decided]

## Rationale
[One-line reason from brief]

## Consequences
[What this implies for the project]
```

For each **Open question**, create `docs/decisions/ADR-NNN-<slug>.md` with status: `proposed` and leave Decision + Rationale as `TBD`.

Number ADRs sequentially starting at ADR-001.

## Step 5 — Initialize session notes

Write the initial entry in `docs/journal/session-notes.md`:
- Stack: from brief
- Last session: "Project initialization from brief"
- Done: list the files created
- Open: list the open question ADRs

## Step 6 — Commit everything

```
[CHORE]: initialize project from brief
```

Single commit containing all created/modified files.

## Step 7 — Print summary

After committing, print:

```
Project initialized.

Created:
  docs/project.md
  docs/architecture.md
  docs/decisions/ADR-001-*.md  (N files)
  docs/journal/session-notes.md

Open questions (ADRs with status: proposed):
  [list them]

Ready for /feature.
```

## Rules

- Never invent information not present in the brief
- Never start coding — this command creates documentation only
- If a section is missing from the brief, note it in the summary as "missing: [section]" and leave the corresponding doc section empty with a `<!-- TODO -->` comment
- One commit, no WIP commits
