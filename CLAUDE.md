# Project rules

## Goal

- Build production-ready code with simple, explicit architecture.
- Prefer small, testable, reversible changes over large rewrites.
- Always verify before shipping: lint, tests, typecheck.

## Workflow

- For changes touching more than 2 files: **explore first, plan, then implement**.
- Before editing, identify impacted files and the verification steps.
- After implementation, run the smallest relevant test/lint command.
- Update `docs/decisions/` or `docs/specs/` when a change affects architecture or observable behavior.

## Commands

```bash
bash scripts/bootstrap.sh  # Install dependencies
bash scripts/test.sh        # Run test suite
bash scripts/lint.sh        # Lint + typecheck
bash scripts/deploy.sh      # Build + deploy via Coolify
```

> Adapt these commands to the actual stack in each project.

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
- Operations & deploy → `@docs/operations/`

## Context management

- Use **subagents** (`.claude/agents/`) for broad investigations to avoid polluting the main context.
- Use **skills** (`.claude/skills/`) to trigger structured workflows.
- When compacting, preserve: modified files, pending decisions, remaining tasks.
- End each session with a note in `docs/journal/session-notes.md`.

## Security

- No credentials, tokens or API keys in source code.
- Check `.gitignore` before committing new config files.
- Tag any sensitive decision in an ADR with `[SECURITY]`.
