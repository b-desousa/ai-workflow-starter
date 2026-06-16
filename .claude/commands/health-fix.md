---
allowed-tools: Read, Write, Bash
description: Targeted docs repair after /health detects drift. Reads only the files changed since the last workflow tag and updates the three core doc files accordingly. Much lighter than /documentor.
---

# /health-fix

> Run `/health` first. This command assumes drift has been detected and a workflow tag exists.

Repair docs drift by reading only what changed since the last workflow tag. No full codebase scan. No ADR generation. Output is limited to the three core doc files + session-notes.

## Step 1 — Identify the delta

```bash
LAST_TAG=$(git describe --tags --match "workflow/*" --abbrev=0)
git diff --name-only $LAST_TAG..HEAD
git log --oneline $LAST_TAG..HEAD
```

Read only the files listed in `git diff --name-only`. Do not read anything else.

## Step 2 — Read current docs

Read the three core files in full:
- `@docs/project.md`
- `@docs/architecture.md`
- `@docs/journal/session-notes.md` (Active section only)

## Step 3 — Update docs (targeted)

Based on the delta files read in Step 1, update only what has actually changed:

- **`session-notes.md`** — always update: rewrite `### Last session` to reflect commits since last tag, move previous entry to History.
- **`architecture.md`** — update only if delta includes structural changes (new module, new dependency, infra file changed).
- **`project.md`** — update only if delta includes changes to scope, target users, or success criteria. This file rarely changes.

Do not rewrite sections that are still accurate. Do not hallucinate changes that are not in the delta.

## Step 4 — Flag missing ADRs

If `package.json`, `pyproject.toml`, `Dockerfile`, or any infra/config file is in the delta and no new ADR exists for that change: print a warning in the report but do not create the ADR automatically. The human decides.

## Step 5 — Commit and tag

```bash
git add docs/
git commit -m "[DOCS]: health-fix — sync docs to $(git rev-parse --short HEAD)"
git tag workflow/health-fix-$(date +%Y-%m-%d-%H%M)
```

## Step 6 — Print report

```
Health fix complete.

Files read:    N source files (delta only)
Docs updated:
- session-notes.md   [updated | unchanged]
- architecture.md    [updated | unchanged]
- project.md         [updated | unchanged]

ADR warnings:
- [list any flagged missing ADRs, or "none"]

New workflow tag: workflow/health-fix-YYYY-MM-DD-HHMM
```
