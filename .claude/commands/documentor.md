---
description: Adopt an existing project into the ai-workflow-starter memory structure. Reads the codebase, generates or enriches docs/, wires the memory map into CLAUDE.md, commits before and after. No code changes. Can be used standalone by copying this single file into .claude/commands/ of any repo.
---

# /documentor

You are about to document an existing project. No code will be modified. The only output is a structured `docs/` memory layer and a `CLAUDE.md` documentation map that future Claude Code sessions can use to load context automatically.

## Principles

- **Read-first**: explore the entire codebase before writing a single doc file.
- **Preserve existing docs**: if a `docs/` already exists, read it fully and enrich it — never overwrite content that is already correct.
- **Preserve existing CLAUDE.md**: if a `CLAUDE.md` already exists, only append the `## Documentation map` section — never modify the rest.
- **Commit safety**: always create a snapshot commit before any change, and a final commit after. Both are mandatory.
- **No code changes**: never modify any file except `docs/` and `CLAUDE.md`.
- **Honest gaps**: if you cannot infer something with confidence, mark it `[TO FILL]` rather than hallucinating.
- **Template-aware**: fetch the latest reference structure from the ai-workflow-starter template at runtime (Step 2).
- **Closed file list**: only create the exact files listed in Step 4. Do not create any additional files, indexes, summaries, or extra docs — even if they seem useful. If in doubt, use `[TO FILL]` inside an existing file instead.

## Step 1 — Safety snapshot commit

Before touching anything, commit the current state:

```bash
git add -A
git commit -m "[CHORE]: snapshot before documentor — $(date +%Y-%m-%d)"
```

If the tree is already clean, create an empty marker commit:

```bash
git commit --allow-empty -m "[CHORE]: snapshot before documentor — $(date +%Y-%m-%d)"
```

This gives the user a guaranteed restore point.

## Step 2 — Fetch template reference (runtime)

Fetch the current structure from the template to stay up to date:

```bash
curl -s https://raw.githubusercontent.com/b-desousa/ai-workflow-starter/main/README.md
curl -s https://raw.githubusercontent.com/b-desousa/ai-workflow-starter/main/CLAUDE.md
```

Use these as your reference for what `docs/` should contain and how it should be structured. Adapt to the project at hand — do not copy verbatim.

## Step 3 — Explore the codebase

Read broadly before writing anything:

- All source files (code, configs, Dockerfiles, CI, package manifests)
- Existing `README.md`, `docs/`, wikis, or any `.md` files at root
- Commit history: `git log --oneline -30`
- Open issues or PR descriptions if accessible

Extract:
- **Project intent** — what does this do, for whom?
- **Stack** — languages, frameworks, databases, infra
- **Architecture** — key modules, data flow, external dependencies
- **Implicit decisions** — tech choices already made, even if undocumented
- **Open questions** — things that seem unresolved or inconsistent

## Step 4 — Generate or enrich docs/

**Allowed output files — exactly these, nothing else:**

```
docs/project.md
docs/architecture.md
docs/decisions/ADR-NNN-<slug>.md   (one per decision, as many as needed)
docs/journal/session-notes.md
```

Do not create any other file. Do not create indexes, summaries, MEMORY.md, README.md, or any file not listed above. Extra information that does not fit these four targets should be added as a `[TO FILL]` note inside the closest relevant file.

If a file already exists, read it first, then add only what is missing or incorrect.

### `docs/project.md`
Vision, scope, target users, success criteria, out-of-scope.
Keep under 300 words. This file is loaded at every session start.

### `docs/architecture.md`
Stack, infra, key modules, data flow, external dependencies, known constraints.
Keep under 400 words.

### `docs/decisions/` — ADRs

One ADR per significant technical decision already made in the codebase. Template:

```markdown
# ADR-NNN: <title>

**Date:** YYYY-MM-DD
**Status:** Accepted

## Context
[Why this decision was needed]

## Decision
[What was decided]

## Consequences
[Trade-offs, what this enables or constrains]
```

Also create `Proposed` ADRs for open questions identified in Step 3.

### `docs/journal/session-notes.md`

```markdown
## Active

### Project state
[One-line: what the project is and where it stands]

### Stack
[Detected stack]

### Last session

**Date:** YYYY-MM-DD
**Focus:** Documentation setup via /documentor

#### Done
- [DOCS]: generated project memory from existing codebase

#### Left open / TODO
- [list open questions or Proposed ADRs]

### Pending decisions
- [from Proposed ADRs]

### Known issues
- [any inconsistencies or gaps found during exploration]
```

## Step 5 — Wire the documentation map into CLAUDE.md

This step ensures Claude automatically loads the memory layer at every future session start.

**If `CLAUDE.md` already exists:**
Check if it already contains a `## Documentation map` section.
- If yes: verify it references the four files below, update if incomplete, do not touch anything else.
- If no: append the following block at the end of the file.

**If `CLAUDE.md` does not exist:**
Create it with only the following content:

```markdown
# CLAUDE.md

## Documentation map

- Project vision & scope → `@docs/project.md`
- Architecture → `@docs/architecture.md`
- Session memory → `@docs/journal/session-notes.md` (Active section only)

> ADRs and feature specs are not loaded by default.
> Load `@docs/decisions/` only when a task involves an architecture or dependency choice.
```

## Step 6 — Final commit

```bash
git add docs/ CLAUDE.md
git commit -m "[DOCS]: generate project memory via documentor"
```

## Step 7 — Print summary

```
Documentor complete.

Snapshot commit: [CHORE]: snapshot before documentor — YYYY-MM-DD
Final commit:    [DOCS]: generate project memory via documentor

Files created or updated:
- docs/project.md                [created | enriched]
- docs/architecture.md           [created | enriched]
- docs/decisions/                N ADRs (X Accepted, Y Proposed)
- docs/journal/session-notes.md  [created | enriched]
- CLAUDE.md                      [created | ## Documentation map appended]

Open questions (Proposed ADRs):
- [list]

[TO FILL] items requiring human input:
- [list anything marked TO FILL]
```

---

> **Standalone usage** — to use this command on any existing repo without cloning the full template:
> ```bash
> mkdir -p .claude/commands
> curl -s https://raw.githubusercontent.com/b-desousa/ai-workflow-starter/main/.claude/commands/documentor.md \
>   -o .claude/commands/documentor.md
> ```
> Then open Claude Code and run `/documentor`.
