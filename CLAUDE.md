# Project rules

These rules are shared by every agent on this repo: Claude chat (planning) and Claude Code (execution).
They are loaded in every session, so keep this file short.

## Principles

- Lean: create a file, folder or abstraction only when there is real content for it. No empty placeholders.
- Small, reversible steps. Verify before claiming anything is done.
- All code, comments, commits and docs in English (user-facing copy follows the product's language).

## Docs are optional

Nothing under `docs/` is required. If a doc, folder or ADR is missing, continue without it and create it only when needed.

| What | Where | Created when |
|---|---|---|
| Spec | `docs/specs/NNN-slug.md` | A feature or change is worth planning |
| ADR | `docs/adr/NNN-slug.md` | A decision with real alternatives is made |
| Index | `docs/INDEX.md` | There are 3+ specs/ADRs (one line each: id, title, status) |

Whoever changes a spec's status also updates `docs/INDEX.md` if it exists.

## Spec format

```markdown
---
status: draft | ready | in-progress | done
---
# SPEC-NNN: Title
## Why
## Acceptance criteria
- [ ] AC1: observable, testable behavior
## Out of scope
## Open questions
## Plan   <!-- filled by the executing agent -->
```

`ready` means the user approved the spec. Only the user decides when a spec becomes `ready`.

## ADR format

```markdown
# ADR-NNN: Title
Status: accepted | superseded by ADR-NNN — Date: YYYY-MM-DD
## Context
## Decision
## Alternatives rejected (and why)
## Consequences
```

## Git

- Docs (`docs/**`, this file) may be committed directly to `main`.
- Code never goes to `main` directly: branch `feat/NNN-slug` (or `fix/…`), then a pull request with passing checks.
- Conventional Commits, referencing the spec when there is one: `feat(auth): lock account after 5 failures (SPEC-012)`.

## Verification

- Run the project's test, lint and typecheck commands before every commit that touches code.
- Once known, record those commands in a `## Commands` section at the end of this file.
- Never weaken or edit a test just to make it pass, unless the spec changed.

## Consistency

If a spec, an ADR and the code disagree, stop and report the contradiction. Do not resolve it silently.
