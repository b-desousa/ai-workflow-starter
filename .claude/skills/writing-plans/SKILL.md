---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

Write implementation plans that guide an agent to build the right thing — not plans that pre-write the code for it. The plan documents **what** to build, **why**, which files, what the interface looks like, and what to test. The agent writes the code.

Assume the engineer is skilled but knows nothing about this codebase or domain. DRY. YAGNI. TDD. Frequent commits.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Save the plan to disk** at `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md` before presenting it. This is mandatory — the file must exist on disk, not just in context.

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
- **Crypto / hashing / IV generation** — one wrong call breaks security silently
- **Complex regex or SQL** — correctness is non-obvious
- **Third-party SDK non-obvious call sequence** — agent would likely get it wrong

> Plans are loaded by every sub-agent. Full code doubles token cost with zero added value — the agent rewrites it from context anyway.

Signatures look like this (inline, no full block):
`export function buildSectionPrompt(key: SectionKey, docSet: DocSet, project: ProjectMeta, repromptCtx?: string): { system: string; prompt: string }` — switch on key, inject docSet fields, throws for unknown key.

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

Every plan starts with this header:

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

Then one section per task:

    ### Task N — [Component Name]

    **Files:** Create `path/to/file.ts` / Modify `path/to/other.ts`

    [2-3 sentences: what, key constraint, why]

    Key interface: `export function foo(bar: BarType): BazType` — one-line logic description.

    - [ ] **Step 1:** Write failing test — `npm test -- path/to/test` — Expected: FAIL
    - [ ] **Step 2:** Run test to confirm it fails
    - [ ] **Step 3:** Implement (see interface above)
    - [ ] **Step 4:** Run test to confirm it passes — Expected: PASS
    - [ ] **Step 5:** Typecheck — `npm run typecheck`
    - [ ] **Step 6:** Commit — `git commit -m "[FEAT]: ..."`

---

## Self-Review

Before saving the file:
1. **Spec coverage:** One task per requirement?
2. **Code audit:** Any full implementation blocks? → Replace with inline signatures.
3. **Test audit:** Any full test bodies? → Replace with it-names + edge cases.
4. **Placeholder scan:** Any TBD / TODO / "similar to Task N"? → Remove.
5. **Budget check:** Within line limit for this feature size?

---

## Execution Handoff

Present summary table (task × file × responsibility) to human → wait for approval → hand off to `subagent-driven-development`.
