---
name: next
description: Implement the next approved spec end-to-end (oldest `status: ready` in docs/specs, or the spec number given as argument) and open a pull request. Use when the user types /next or asks to run pending specs.
disable-model-invocation: true
---

# /next

Target: spec `$ARGUMENTS` if given, otherwise the lowest-numbered spec in `docs/specs/` with `status: ready`.
If there is none, say so and stop.

## 1. Check before acting

- Read the spec and any ADR it links. Skim the code it touches.
- If "Open questions" is not empty, or the spec contradicts an ADR or the code: stop, list the questions, leave the status unchanged.

## 2. Claim it (visible from the chat)

- On an up-to-date `main`: set `status: in-progress`, update `docs/INDEX.md` if it exists, commit `docs: start SPEC-NNN`, push `main`.
- Create branch `feat/NNN-slug` from `main`.

## 3. Plan, then execute

- Write a short task list in the spec's `## Plan` section (each task = one reviewable commit). No approval needed: `ready` is the approval.
- For each task: failing test first when practical → implement → run checks → commit (Conventional Commits, `(SPEC-NNN)`).

## 4. Verify

- Run the full test, lint and typecheck commands (see `## Commands` in CLAUDE.md; add them there if missing).
- Each acceptance criterion must be backed by a test or a command output. If one cannot be met, stop and report instead of working around it.

## 5. Close

- In the spec: tick the ACs, set `status: done`. Update `docs/INDEX.md` if it exists.
- If a real decision was made along the way, add an ADR.
- Push the branch and open a pull request: title = spec title, body = link to the spec, AC checklist, verification summary, any deviation from the spec.
- Report to the user in 3 lines max: PR link, what was done, what needs their attention.
