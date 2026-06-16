---
description: Plan and execute a new feature using subagent-driven development. Provide a short feature description.
---

# /feature

You are about to implement a new feature. The human has already done the brainstorming and conceptualization outside of this session. Your job is to translate their brief into a rigorous plan, get a single approval, then execute automatically without interruption.

## Step 1 — Safety snapshot commit

Before touching anything, commit the current state on the current branch:

```bash
git add -A
git commit -m "[CHORE]: snapshot before feature — $(date +%Y-%m-%d)"
```

If the tree is already clean, create an empty marker commit:

```bash
git commit --allow-empty -m "[CHORE]: snapshot before feature — $(date +%Y-%m-%d)"
```

This gives the user a guaranteed restore point before any branch or file is touched.

## Step 2 — Write the plan

Use the `writing-plans` skill:
- Read `@docs/project.md` and `@docs/architecture.md` for context
- Map all files to create or modify with exact paths
- Break the feature into atomic tasks (2-5 min each), each with exact code, exact commands, expected outputs
- Follow TDD: failing test → implementation → passing test → commit per task
- Commit format: `[TYPE]: description` (see CLAUDE.md for allowed types)
- **Do not save the plan to disk.** Hold it in context and present the summary below.

**After writing the plan, present a summary:**
```
Tasks: N tasks across X files
[Task 1 title]
[Task 2 title]
...

Architecture impact: [none | yes — describe]

Ready to execute? (yes / [corrections])
```

Wait for approval. This is the only human checkpoint.

## Step 3 — Execute with subagent-driven development

Once approved, use the `subagent-driven-development` skill:

- **Never start on `main`** — create a worktree/branch: `feat/<feature-slug>`
- Dispatch one fresh subagent per task with full task text + codebase context
- After each task: two-stage review (spec compliance → code quality), fix loops if needed
- Use `verification-before-completion` before every commit claim
- Mark each task done in TodoWrite
- After all tasks: dispatch final reviewer

**Do not pause between tasks. Do not ask “should I continue?”. Execute the full plan.**

## Step 4 — Wrap up

1. Update `docs/journal/session-notes.md` following the Active/History structure:
   - **Rewrite `### Last session`** in `## Active` with what was just done, decisions made, and what remains open
   - **Update `### Known issues`** and **`### Pending decisions`** in `## Active` if anything changed
   - **Archive the previous session entry** to `## History` (one-line table row, newest first)

2. Update `docs/architecture.md` if structure changed.

3. Create or update `docs/specs/features/<slug>.md`.

4. **If the feature introduced an architecture decision** (new dependency, new pattern, structural change): create `docs/decisions/ADR-NNN-<slug>.md` with status `Accepted`. Use the standard ADR template (Context / Decision / Consequences). Do not skip this step — implicit decisions are the most dangerous ones.

Final commit: `[DOCS]: update session notes, feature spec and ADRs`

## On bugs encountered during execution

Use `systematic-debugging`:
- Never propose a fix without root cause investigation first
- 4 phases: root cause → pattern analysis → hypothesis → implementation
- If 3+ fixes failed: stop and surface architectural question to human
