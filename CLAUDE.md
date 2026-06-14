# Project rules

## Goal

- Build production-ready code with simple, explicit architecture.
- Prefer small, testable, reversible changes over large rewrites.
- Always verify before shipping: lint, tests, typecheck.

## Language

- All code, comments, commit messages, and documentation must be written in **English**.
- Exception: user-facing copy follows the product's target language.

## Workflow

- For changes touching more than 2 files: explore first, plan, then implement.
- Before editing, identify impacted files and verification steps.
- After implementation, run the smallest relevant test/lint command.

## Commit conventions

Use the following prefix format for all commits:

```
[TYPE]: short description
```

Allowed types:
- `[FEAT]` – new feature or capability
- `[FIX]` – bug fix
- `[REFACTOR]` – code change that neither fixes a bug nor adds a feature
- `[DOCS]` – documentation only changes
- `[TEST]` – adding or updating tests
- `[CHORE]` – build process, tooling, dependencies
- `[PERF]` – performance improvements
- `[STYLE]` – formatting, whitespace, missing semi-colons, no logic change
- `[REVERT]` – reverts a previous commit

Example: `[FEAT]: files processing`

Rules:
- Subject line: imperative mood, max 72 chars, no trailing period.
- Scope is optional: `[FEAT](auth): add OAuth2 login`
- Body (optional): explain *why*, not *what*. Separated by a blank line.

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

> Fill in once the stack is known. Template below — replace with real commands.

```bash
# Install dependencies
npm install          # or: pip install -r requirements.txt / poetry install

# Development server
npm run dev          # or: python -m uvicorn app.main:app --reload

# Run tests
npm test             # or: pytest / cargo test

# Lint & format
npm run lint         # or: ruff check . / eslint .
npm run format       # or: ruff format . / prettier --write .

# Typecheck
npm run typecheck    # or: pyright / tsc --noEmit

# Build for production
npm run build        # or: docker compose build

# Start production
npm start            # or: docker compose up
```

> Claude should run the smallest relevant command after each change.
> Example: touched only a test file → run only `npm test`, not the full pipeline.

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
