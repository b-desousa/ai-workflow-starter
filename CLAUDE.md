# Project rules

## Goal

- Build production-ready code with simple, explicit architecture.
- Prefer small, testable, reversible changes over large rewrites.
- Always verify before shipping: lint, tests, typecheck.

## Workflow

- For changes touching more than 2 files: **explore first, plan, then implement**.
- Before editing, identify impacted files and the verification steps.
- After implementation, run the smallest relevant test/lint command.
- Update `docs/decisions/` or `docs/specs/` when a change affects architecture or behavior.

## Commands

> Add project-specific commands here once the stack is known.
> e.g. `npm run dev`, `pytest`, `docker compose up`

## Code conventions

- Explicit naming, small functions, flat hierarchy.
- Follow existing patterns before introducing new abstractions.
- No new dependency without a justification in an ADR.
- Secrets in env vars only, never in source.

## Documentation map

- Project vision → `@docs/project/vision.md`
- Architecture overview → `@docs/architecture/overview.md`
- Active feature specs → `@docs/specs/features/`
- Architecture decisions → `@docs/decisions/`

## Context management

- Use **subagents** (`.claude/agents/`) for broad investigations.
- Use **skills** (`.claude/skills/`) for structured workflows.
- When compacting, preserve: modified files, pending decisions, remaining tasks.
- End each session with `/session-close`.

## Security

- No credentials, tokens or API keys in source code.
- Check `.gitignore` before committing new config files.
