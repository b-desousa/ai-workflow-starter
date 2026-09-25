---
name: next
description: Spec-driven workflow. Shows the spec/ADR board and implements approved specs end-to-end with a pull request. Use when the user types /next, /next NNN or /next all.
disable-model-invocation: true
---

# /next

This file is the single source for the spec workflow (formats, statuses, procedure). The chat planner reads it too.

| Command | Behavior |
|---|---|
| `/next` | Show the board, suggest one spec in one line, ask the user which to run |
| `/next NNN` | Run spec NNN |
| `/next all` | Run every `ready` spec, never waiting for the user |

Arguments: `$ARGUMENTS`

## Docs

Nothing under `docs/` is required: if a file or folder is missing, continue and create it only when there is real content.

- Specs: `docs/specs/NNN-slug.md`. ADRs: `docs/adr/NNN-slug.md`. Numbers are sequential, 3 digits.

Spec format:

```markdown
---
status: draft | ready | in-progress | done
depends: SPEC-NNN   # optional
---
# SPEC-NNN: Title
## Why
## Acceptance criteria
- [ ] AC1: observable, testable behavior
## Out of scope
## Open questions
## Plan   <!-- filled by the executing agent -->
```

`ready` = approved by the user. Only the user sets a spec to `ready`.

ADR format:

```markdown
# ADR-NNN: Title
Status: proposed | accepted | superseded by ADR-NNN — Date: YYYY-MM-DD
## Context
## Decision
## Alternatives rejected (and why)
## Consequences
```

`proposed` = decided by an agent, waiting for the user's review.

## Board (`/next` without argument)

List non-`done` specs and `proposed` ADRs, one line each (id, title, status, depends). Read frontmatter and titles only.
Suggest one `ready` spec in one line, based only on the board (dependencies first). Then ask the user which spec to run.
Closing drafts and proposed ADRs is discussed with the planner (chat), not here.

## Running one spec

1. **Check.** Read the spec, its linked ADRs and the code it touches. Non-empty "Open questions" or a contradiction = blocked (see Decisions).
2. **Claim.** On an up-to-date `main`: set `status: in-progress`, commit `docs: start SPEC-NNN`, push `main`.
   Branch `feat/NNN-slug` from `main`, or from the dependency's branch if its PR is not merged yet (then target the PR at that branch).
3. **Plan and execute.** Write a short task list in `## Plan`. No approval needed: `ready` is the approval.
   Per task: failing test first when practical, implement, run the checks, commit.
4. **Verify.** Run all commands from CLAUDE.md (add them there if missing). Every AC must be backed by a test or command output.
5. **Close.** Tick the ACs, set `status: done`. Push, open a PR: spec link, AC checklist, verification summary, `## Assumptions`, links to proposed ADRs.
6. **Report** in 3 lines max: PR link, what was done, what needs the user's attention.

## Decisions the spec did not make

Judge by the cost of being wrong:

- **Cheap to undo** (naming, internal structure, test tooling): decide, list it under `## Assumptions` in the PR.
- **Costly to undo, with a reasonable default** (data model, public API, new dependency, infra, security): decide, write an ADR with `Status: proposed`, link it in the PR.
- **Costly, and depends on product intent**: blocked. Set the spec back to `draft`, write the question under "Open questions", commit it to `main`. With `/next NNN`, stop and ask; with `/next all`, skip to the next spec.

## `/next all`

- Order: dependencies first, then by number. Skip specs whose dependency is blocked.
- Run each spec in a fresh subagent with this procedure, to keep context (and quota) small.
- End with one report: PRs opened, specs sent back to `draft` (with their question), proposed ADRs.
