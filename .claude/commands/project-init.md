---
description: One-time project initialization from a project brief. Fills all docs, creates ADRs, initializes session memory.
---

# /project-init

> **New projects only.** This command expects a human-written brief and an empty (or code-free) repository.
> For existing codebases with code already written, use `/documentor` instead.

You are initializing a new project from a brief provided by the human. The brief was written outside Claude Code. Your job is to translate it into structured project memory — no code, no implementation.

## Step 1 — Fill core docs

From the brief, write:

- **`docs/project.md`** — vision, scope, target users, success criteria, out-of-scope
- **`docs/architecture.md`** — chosen stack, infra, key technical constraints, external dependencies

Be concise. These files will be loaded at every session start — keep them under 300 words each.

## Step 2 — Create ADRs

For each significant technical decision in the brief:
- Create `docs/decisions/ADR-NNN-<decision-slug>.md` using the template in `docs/decisions/`
- Status: `Accepted` for decided choices, `Proposed` for open questions
- Number sequentially starting from `ADR-001`

Minimum: one ADR per major dependency or architectural pattern chosen.

## Step 3 — Initialize session memory

Write `docs/journal/session-notes.md` — `## Active` section only.

Fill it with real content from the brief:

```markdown
## Active

### Project state
[One-line: what the project is and where it stands — e.g. "Auth service — initialized, no code yet"]

### Stack
[Stack line from brief — e.g. "FastAPI · Postgres · SQLAlchemy · Docker"]

### Last session

**Date:** YYYY-MM-DD  
**Duration:** ~X min  
**Focus:** Project initialization from brief

#### Done
- [DOCS]: initialized project from brief
- [DOCS]: created ADRs for [list key decisions]

#### Left open / TODO
- [First feature to implement, from brief]
- [Any open architectural question flagged as Proposed ADR]

### Pending decisions
- [Open choices not yet resolved — from Proposed ADRs]

### Known issues
- _none_
```

Leave `## History` as-is (template row only).

## Step 4 — Commit everything

Single commit:
```
[CHORE]: initialize project from brief
```

## Step 5 — Print summary

```
Project initialized.

Docs created:
- docs/project.md
- docs/architecture.md
- docs/decisions/ (N ADRs)
- docs/journal/session-notes.md

Open decisions (Proposed ADRs):
- [list]

Suggested first /feature:
- [first feature from brief, or "not specified"]
```
