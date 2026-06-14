---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

Execute plan by dispatching a fresh subagent per task, with two-stage review after each: spec compliance first, then code quality.

**Core principle:** Fresh subagent per task + two-stage review = high quality, fast iteration.

**Continuous execution:** Do not pause between tasks. Do not ask "should I continue?". Execute all tasks from the plan without stopping. The only reasons to stop: BLOCKED status you cannot resolve, ambiguity that genuinely prevents progress, or all tasks complete.

## The Process

1. Read plan file once, extract all tasks with full text, create TodoWrite
2. For each task:
   - Dispatch fresh **implementer subagent** with full task text + codebase context
   - If subagent asks questions → answer completely before letting them proceed
   - Implementer implements, runs tests, self-reviews, commits
   - Dispatch **spec compliance reviewer** → confirm code matches spec
   - If issues → implementer fixes → re-review until ✅
   - Dispatch **code quality reviewer** → approve implementation
   - If issues → implementer fixes → re-review until ✅
   - Mark task complete in TodoWrite
3. After all tasks: dispatch final reviewer for full implementation
4. Use `verification-before-completion` before any completion claim

## Model Selection

- Mechanical tasks (1-2 files, clear spec) → fast/cheap model
- Integration tasks (multi-file, coordination) → standard model
- Architecture/review tasks → most capable model

## Handling Implementer Status

- **DONE** → proceed to spec review
- **DONE_WITH_CONCERNS** → read concerns, address if correctness issue, else note and proceed
- **NEEDS_CONTEXT** → provide context, re-dispatch
- **BLOCKED** → provide more context, upgrade model, split task, or escalate to human

## Red Flags — Never

- Start on `main`/`master` without explicit user consent
- Skip spec compliance OR code quality review
- Proceed with unfixed issues
- Dispatch parallel implementation subagents (conflicts)
- Make subagent read plan file (provide full text instead)
- Start code quality review before spec compliance is ✅
- Move to next task with open issues
- Accept "close enough" on spec compliance
