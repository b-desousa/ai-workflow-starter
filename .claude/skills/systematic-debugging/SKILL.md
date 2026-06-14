---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---

# Systematic Debugging

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

## The Four Phases

Complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

1. Read error messages completely (stack traces, line numbers, file paths)
2. Reproduce consistently — if not reproducible, gather more data
3. Check recent changes — git diff, new deps, config changes
4. In multi-component systems: add diagnostic instrumentation at each boundary, run once to see WHERE it breaks
5. Trace data flow backward to origin of bad value

### Phase 2: Pattern Analysis

1. Find working examples of similar code in the codebase
2. Compare against references — read completely, don't skim
3. List every difference, however small

### Phase 3: Hypothesis and Testing

1. State clearly: "I think X is the root cause because Y"
2. Make the SMALLEST possible change to test hypothesis
3. One variable at a time — never bundle multiple fixes
4. Did it work? Yes → Phase 4. No → new hypothesis, start over

### Phase 4: Implementation

1. Create failing test case first
2. Implement single fix — root cause only, no "while I'm here"
3. Verify fix: tests pass, no regressions
4. If fix doesn't work after 3 attempts → STOP, question architecture, escalate to human

## Red Flags — STOP and Follow Process

- "Quick fix for now, investigate later"
- "Just try changing X and see"
- "I don't fully understand but this might work"
- "One more fix attempt" (when already tried 2+)
- Proposing solutions before tracing data flow

## If 3+ Fixes Failed

This is not a failed hypothesis — this is a wrong architecture. Stop, discuss with human before attempting more fixes.
