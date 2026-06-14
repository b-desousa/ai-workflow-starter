---
description: Plan and execute a new feature using subagent-driven development. Provide a short feature description.
---

# /feature

You are about to implement a new feature. The human has already done the brainstorming and conceptualization outside of this session. Your job is to translate their brief into a rigorous plan, get a single approval, then execute automatically without interruption.

## Step 1 — Write the plan

Use the `writing-plans` skill:
- Read `@docs/project.md` and `@docs/architecture.md` for context
- Map all files to create or modify with exact paths
- Break the feature into atomic tasks (2-5 min each), each with exact code, exact commands, expected outputs
- Follow TDD: failing test → implementation → passing test → commit per task
- Save plan to `docs/superpowers/plans/YYYY-MM-DD-<feature-slug>.md`
- Commit format: `[TYPE]: description` (see CLAUDE.md for allowed types)

**After writing the plan, present a summary:**
```
Plan: docs/superpowers/plans/<filename>.md
Tasks: N tasks across X files
[Task 1 title]
[Task 2 title]
...

Ready to execute? (yes / [corrections])
```

Wait for approval. This is the only human checkpoint.

## Step 2 — Execute with subagent-driven development

Once approved, use the `subagent-driven-development` skill:

- **Never start on `main`** — create a worktree/branch: `feat/<feature-slug>`
- Dispatch one fresh subagent per task with full task text + codebase context
- After each task: two-stage review (spec compliance → code quality), fix loops if needed
- Use `verification-before-completion` before every commit claim
- Mark each task done in TodoWrite
- After all tasks: dispatch final reviewer, then run `/session-close` equivalent

**Do not pause between tasks. Do not ask "should I continue?". Execute the full plan.**

## Step 3 — Wrap up

- Update `docs/journal/session-notes.md` (Last session, Active context, Session history)
- Update `docs/architecture.md` if structure changed
- Create or update `docs/specs/features/<slug>.md`
- Final commit: `[DOCS]: update session notes and feature spec`

## On bugs encountered during execution

Use `systematic-debugging`:
- Never propose a fix without root cause investigation first
- 4 phases: root cause → pattern analysis → hypothesis → implementation
- If 3+ fixes failed: stop and surface architectural question to human
