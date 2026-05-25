# Project rules

## Goal

- Build production-ready code with simple, explicit architecture.
- Prefer small, testable, reversible changes over large rewrites.
- Always verify before shipping: lint, tests, typecheck.

## Workflow

- For changes touching more than 2 files: explore first, plan, then implement.
- Before editing, identify impacted files and verification steps.
- After implementation, run the smallest relevant test/lint command.

## Auto-documentation (mandatory)

After every implementation — whether asked or not:
- If the change introduces or modifies a feature → create or update `docs/specs/features/<slug>.md`
- If the change involves a significant technical choice → create or update an ADR in `docs/decisions/`
- If the change affects the overall architecture → update `docs/architecture.md`

Do this silently as part of the commit. Never ask for permission to document.

## Code conventions

- Explicit naming, small functions, flat hierarchy.
- Follow existing patterns before new abstractions.
- No new dependency without an ADR.
- Secrets in env vars only, never in source.

## Commands

> Fill in once the stack is known.
> e.g. `npm run dev`, `pytest`, `docker compose up`

## Documentation map

- Project vision & scope → `@docs/project.md`
- Architecture → `@docs/architecture.md`
- Feature specs → `@docs/specs/features/`
- Decisions → `@docs/decisions/`
- Session memory → `@docs/journal/session-notes.md`

## Context rules

- Subagents (`.claude/agents/`) for large investigations.
- Skills (`.claude/skills/`) for structured workflows.
- End of session: `/session-close`.
- Secrets: never in source, check `.gitignore` before commit.
