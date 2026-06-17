---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write implementation plans that guide an agent to build the right thing — not plans that pre-write the code for it.

**The plan documents: what to build, why, which files, what the interface looks like, and what to test.**
**The agent writes the code. You do not.**

Assume the engineer is skilled but knows nothing about this codebase or domain. Give them orientation, clear interfaces, and enough TDD scaffolding to start — not a copy of the final implementation.

DRY. YAGNI. TDD. Frequent commits.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

---

## Context Loading (token budget — follow strictly)

Before writing the plan, load **only what the feature directly needs**:

| Always load | Load only if impacted | Never load proactively |
|---|---|---|
| `@docs/project.md` | `@docs/architecture.md` (architecture change) | All ADRs at once |
| `@CLAUDE.md` | Specific ADR file (dependency/infra decision) | Entire `docs/decisions/` |
| `@docs/journal/session-notes.md` (Active section only) | `@DESIGN.md` (UI work only) | Full codebase tree (`find .`, `ls -R`) |
| Files the feature will modify | | |

Read only the **Active** section of `session-notes.md`, not the full history.
If unsure which files are impacted, read `@docs/architecture.md` first, then target specific files.

---

## Plan Budget

Keep plans strictly proportional to feature complexity:

| Feature size | Tasks | Max plan length | Code in plan? |
|---|---|---|---|
| Simple (1-3 files) | 2-4 | ~100 lines | Nothing — prose only |
| Standard (4-8 files) | 4-7 | ~250 lines | Signatures + types only |
| Complex (architecture change) | 7-12 | ~450 lines | Non-obvious patterns only |

### The Code Rule

**Never write full implementation code in a plan.**

The only exceptions — write the exact code block when the implementation is:
- **Crypto / hashing / IV generation** — one wrong call breaks security silently
- **Complex regex or SQL** — correctness is non-obvious
- **Third-party SDK wiring** — when the SDK has a non-obvious call sequence that Claude would likely get wrong

For everything else: **signatures, types, and a one-line description of the logic** are enough.

> Why: plans are loaded by every sub-agent executing a task. Full implementation code in the plan doubles the token cost without adding value — the agent will rewrite it anyway based on context.

### What "signatures only" looks like

❌ **Too much (costs tokens, agent ignores it anyway):**
```typescript
export function buildSectionPrompt(
  key: SectionKey,
  docSet: DocSet,
  project: ProjectMeta,
  repromptContext?: string
): SectionPrompt {
  const ctx = repromptContext ? `\n\nAdditional context: ${repromptContext}` : "";
  switch (key) {
    case "hero":
      return { system: SYSTEM, prompt: `Write a 2-line hero pitch...${ctx}` };
    // ... 80 more lines
  }
}
```

✅ **Right level (agent has everything it needs):**
```typescript
// lib/prompt-builder.ts
export type SectionKey = "hero" | "problem-solution" | "tech-stack" | "key-decisions" | "cta";
export const SECTION_KEYS: SectionKey[] = [...];
export function buildSectionPrompt(key: SectionKey, docSet: DocSet, project: ProjectMeta, repromptContext?: string): { system: string; prompt: string }
// Switch on key → return { system, prompt }. Each prompt: ~3-4 lines of instruction + relevant docSet fields injected.
// Throws for unknown key.
```

---

## Scope Check

If the spec covers multiple independent subsystems, suggest breaking into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

---

## File Map

Before defining tasks, produce a concise table:

```markdown
| Action | Path | Responsibility |
|---|---|---|
| Create | `lib/llm.ts` | Provider factory → LanguageModel |
| Create | `lib/prompt-builder.ts` | 5-section prompt builder |
...
```

---

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the failing test" — step
- "Run it to confirm it fails" — step
- "Implement minimal code to pass" — step
- "Run tests, confirm pass" — step
- "Commit" — step

---

## Plan Document Header

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use subagent-driven-development to implement this plan task-by-task.

**Goal:** [One sentence]
**Architecture:** [2-3 sentences — decisions made, not implementation details]
**Tech Stack:** [Key technologies only]
**Decisions locked:** [Bullet list — do not re-open these]

---
```

---

## Task Structure

````markdown
### Task N — [Component Name]

**Files:**
- Create: `exact/path/to/file.ts`
- Modify: `exact/path/to/existing.ts`

[2-3 sentences: what this component does, its key constraint, why it exists]

Key interface:
```typescript
// Signatures + types only — no implementation
export function foo(bar: BarType): BazType
// Throws if X. Returns Y shaped like Z.
```

- [ ] **Step 1:** Write failing test — `npm test -- path/to/test`
- [ ] **Step 2:** Implement (see interface above)
- [ ] **Step 3:** Typecheck — `npm run typecheck`
- [ ] **Step 4:** Commit — `git commit -m "[FEAT]: ..."`
````

---

## TDD Test Scaffolding

For testable units (pure functions, utilities), write the **test structure** — describe blocks, `it()` names, and the input/expected values — without the full implementation of each assertion.

❌ Too much:
```typescript
it("hero — prompt contains projectMd content", () => {
  const { prompt } = buildSectionPrompt("hero", docSet, project);
  expect(prompt).toContain("auto-generate portfolio");
});
// ... 9 more full test bodies
```

✅ Right level:
```typescript
describe("buildSectionPrompt", () => {
  // hero: system non-empty, prompt contains repo name and "2 lines", uses projectMd (falls back to readme)
  // problem-solution: prompt contains "Problem" and "Solution" labels
  // tech-stack: prompt contains architectureMd content
  // key-decisions: includes all ADR contents; falls back to "No decision records" when empty
  // cta: prompt contains repoUrl
  // repromptContext: appended when provided
  // unknown key: throws
})
// 11 tests total
```

The agent writes the full assertions. You name what to test and the edge cases.

---

## No Placeholders

Every task must be actionable. Never write:
- "TBD", "TODO", "implement later"
- "Add appropriate error handling"
- "Similar to Task N" without repeating the relevant interface

---

## Self-Review Checklist

After writing the plan:
1. **Spec coverage:** Can you point to a task for each requirement?
2. **Code audit:** Any full implementation blocks? Replace with signatures + one-line description.
3. **Test audit:** Any full test bodies? Replace with describe + it-names + edge cases.
4. **Budget check:** Within line limit for this feature size?
5. **Type consistency:** Do signatures match across tasks?

---

## Execution Handoff

Present a summary table (task × file × responsibility) to the human, wait for approval, then hand off to `subagent-driven-development`.
