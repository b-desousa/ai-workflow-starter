---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

Write implementation plans that guide an agent to build the right thing — not plans that pre-write the code for it. The plan documents **what** to build, **why**, which files, what the interface looks like, and what to test. The agent writes the code.

Assume the engineer is skilled but knows nothing about this codebase or domain. DRY. YAGNI. TDD. Frequent commits.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."
**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

---

## Context Loading

Load **only what the feature directly needs**:

| Always | Only if impacted | Never |
|---|---|---|
| `@docs/project.md` | `@docs/architecture.md` | All ADRs at once |
| `@CLAUDE.md` | Specific ADR (if dependency) | Entire `docs/decisions/` |
| `@docs/journal/session-notes.md` (Active section only) | `@DESIGN.md` (UI only) | Full codebase tree |
| Files the feature will modify | | |

---

## Plan Budget

| Feature size | Tasks | Max lines | Code in plan? |
|---|---|---|---|
| Simple (1-3 files) | 2-4 | ~100 | Nothing — prose only |
| Standard (4-8 files) | 4-7 | ~250 | Signatures + types only |
| Complex (architecture change) | 7-12 | ~450 | Non-obvious patterns only |

### The Code Rule

**Never write full implementation code.** Signatures + types + one-line logic description is enough.

Exceptions — write exact code only for:
- **Crypto / hashing / IV generation** — wrong call breaks security silently
- **Complex regex or SQL** — correctness is non-obvious
- **Third-party SDK non-obvious call sequence** — agent would likely get it wrong

> Plans are loaded by every sub-agent. Full code doubles token cost with zero added value — the agent rewrites it from context anyway.

**Signatures look like this:**
```typescript
// lib/prompt-builder.ts
export type SectionKey = "hero" | "problem-solution" | "tech-stack" | "key-decisions" | "cta";
export function buildSectionPrompt(key: SectionKey, docSet: DocSet, project: ProjectMeta, repromptCtx?: string): { system: string; prompt: string }
// Switch on key → { system, prompt }. Inject relevant docSet fields. Throws for unknown key.
```

### TDD Scaffolding Rule

Write test **structure** only — describe block, `it()` names, edge cases. Agent writes the assertions.

```typescript
describe("buildSectionPrompt", () => {
  // hero: system non-empty, contains repo name + "2 lines"; falls back to readme when projectMd absent
  // tech-stack: contains architectureMd content
  // key-decisions: falls back to "No decision records" when decisionsMd empty
  // repromptCtx: appended when provided
  // unknown key: throws
}) // ~8 tests
```

---

## Scope Check

If the spec spans multiple independent subsystems, split into separate plans — one per subsystem, each deployable on its own.

---

## Plan Document Structure

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use subagent-driven-development to implement this plan task-by-task.

**Goal:** [One sentence]
**Architecture:** [2-3 sentences — decisions made, not implementation details]
**Tech Stack:** [Key technologies only]
**Decisions locked:** [Do not re-open these]

## File Map
| Action | Path | Responsibility |
|---|---|---|
| Create | `lib/foo.ts` | ... |

---

### Task N — [Component Name]

**Files:** Create `path/to/file.ts` / Modify `path/to/other.ts`

[2-3 sentences: what, key constraint, why]

```typescript
// Signatures + types only
export function foo(bar: BarType): BazType // one-line logic description
```

- [ ] Write failing test — `npm test -- path/to/test`
- [ ] Implement
- [ ] Typecheck — `npm run typecheck`
- [ ] Commit — `git commit -m "[FEAT]: ..."`
```

---

## Self-Review

1. **Spec coverage:** One task per requirement?
2. **Code audit:** Any full implementation blocks? → Replace with signatures.
3. **Test audit:** Any full test bodies? → Replace with it-names + edge cases.
4. **Placeholder scan:** Any TBD / TODO / "similar to Task N"? → Remove.
5. **Budget check:** Within line limit?

---

## Execution Handoff

Present summary table (task × file × responsibility) to human → wait for approval → hand off to `subagent-driven-development`.
