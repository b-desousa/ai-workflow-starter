# Project rules

Project: _not described yet — ask the user for one sentence and replace this line._

## Commands

_Not known yet — add test, lint, typecheck and build commands here once they exist._

## Rules

- All code, comments, commits and docs in English (user-facing copy follows the product's language).
- Code never goes to `main` directly: `feat/…` or `fix/…` branch, then a pull request with passing checks. Docs (`docs/**`, this file) may go straight to `main`.
- Conventional Commits, with the spec reference when there is one: `feat(auth): lock account after 5 failures (SPEC-012)`.
- Run the commands above before each commit that touches code. Never weaken a test to make it pass unless the spec changed.
- If a spec, an ADR and the code disagree, stop and report it. Do not resolve it silently.
- Specs and ADRs live in `docs/`; their formats and workflow are in `.claude/skills/next/SKILL.md`.
- If the session-start board lists drafts or proposed ADRs, mention them in one line in your first reply.
