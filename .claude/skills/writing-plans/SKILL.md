---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write comprehensive implementation plans assuming the engineer has zero context for our codebase and questionable taste. Document everything they need to know: which files to touch for each task, code, testing, docs they might need to check, how to test it. Give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

## Context Loading (token budget — follow strictly)

Before writing the plan, load **only what the feature directly needs**:

| Always load | Load only if impacted | Never load proactively |
|---|---|---|
| `@docs/project.md` | `@docs/architecture.md` (architecture change) | All ADRs at once |
| `@CLAUDE.md` | Specific ADR file (dependency/infra decision) | Entire `docs/decisions/` |
| `@docs/journal/session-notes.md` (Active section only) | `@DESIGN.md` (UI work only) | Full codebase tree (`find .`, `ls -R`) |
| Files the feature will modify | | |

`session-notes.md` is intentional short-term memory — always load it. Read only the **Active** section, not the full history.

Do **not** `find .` or `ls -R` the full codebase. Read only the files the feature will touch.
If unsure which files are impacted, read `@docs/architecture.md` first, then target specific files.

## Plan Budget

Keep plans proportional to feature complexity:

| Feature size | Tasks | Max plan length | Code in plan? |
|---|---|---|---|
| Simple (1-3 files) | 2-4 | ~150 lines | Signatures only |
| Standard (4-8 files) | 4-7 | ~400 lines | Key logic only |
| Complex (architecture change) | 7-12 | ~700 lines | Full code where ambiguous |

**Code inline in plans:** only write full code blocks when the implementation is non-obvious or error-prone (e.g. crypto, regex, complex SQL). For CRUD, form handlers, and standard patterns — signatures and types are enough.

## Scope Check

If the spec covers multiple independent subsystems, suggest breaking into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for.

- Design units with clear boundaries and well-defined interfaces.
- Prefer smaller, focused files over large ones.
- Files that change together should live together.
- In existing codebases, follow established patterns.

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the failing test" — step
- "Run it to make sure it fails" — step
- "Implement the minimal code to make the test pass" — step
- "Run the tests and make sure they pass" — step
- "Commit" — step

## Plan Document Header

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use subagent-driven-development to implement this plan task-by-task.

**Goal:** [One sentence]
**Architecture:** [2-3 sentences]
**Tech Stack:** [Key technologies]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py`
- Test: `tests/exact/path/to/test.py`

- [ ] **Step 1: Write the failing test**
```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```
- [ ] **Step 2: Run test to verify it fails**
  Run: `pytest tests/path/test.py::test_name -v`
  Expected: FAIL

- [ ] **Step 3: Write minimal implementation**
```python
def function(input):
    return expected
```
- [ ] **Step 4: Run test to verify it passes**
  Run: `pytest tests/path/test.py::test_name -v`
  Expected: PASS

- [ ] **Step 5: Commit**
```bash
git add tests/path/test.py src/path/file.py
git commit -m "[FEAT]: add specific feature"
```
````

## No Placeholders

Every step must contain the actual content. Never write:
- "TBD", "TODO", "implement later"
- "Add appropriate error handling"
- "Similar to Task N" (repeat the code)
- Steps without showing the actual code (exception: standard CRUD patterns — signatures suffice)

## Self-Review

After writing the plan:
1. **Spec coverage:** Can you point to a task for each requirement?
2. **Placeholder scan:** Any red-flag phrases above?
3. **Type consistency:** Do method signatures match across all tasks?
4. **Budget check:** Is the plan within the line budget for this feature size?

## Execution Handoff

Present summary to human, wait for single approval, then hand off to `subagent-driven-development`.
