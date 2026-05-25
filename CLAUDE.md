# Project rules

## Goal

- Build production-ready code with simple, explicit architecture.
- Prefer small, testable, reversible changes over large rewrites.
- Always verify before shipping: lint, tests, typecheck.

## Workflow

- For changes touching more than 2 files: **explore first, plan, then implement**.
- Before editing, identify impacted files and verification steps.
- After implementation, run the smallest relevant test/lint command.
- Update `docs/decisions/` or `docs/specs/` when a change affects architecture or behavior.

## Commands

> Renseigner ici les commandes du projet une fois le stack connu.
> ex: `npm run dev`, `pytest`, `docker compose up`

## Code conventions

- Explicit naming, small functions, flat hierarchy.
- Follow existing patterns before new abstractions.
- No new dependency without an ADR.
- Secrets in env vars only, never in source.

## Documentation map

- Project vision & scope → `@docs/project.md`
- Architecture → `@docs/architecture.md`
- Feature specs → `@docs/specs/`
- Decisions → `@docs/decisions/`

## Context rules

- Subagents (`.claude/agents/`) pour investigations larges.
- Skills (`.claude/skills/`) pour workflows structurés.
- Fin de session : `/session-close`.
- Secrets : jamais dans le source, vérifier `.gitignore` avant commit.
