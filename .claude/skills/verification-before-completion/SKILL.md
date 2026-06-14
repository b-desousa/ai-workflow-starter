---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing — before committing or creating PRs. Evidence before assertions, always.
---

# Verification Before Completion

**Core principle:** Evidence before claims, always. Claiming work is complete without verification is dishonesty, not efficiency.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command in this message, you cannot claim it passes.

## The Gate Function

BEFORE claiming any status or expressing satisfaction:

1. **IDENTIFY** — What command proves this claim?
2. **RUN** — Execute the FULL command (fresh, complete)
3. **READ** — Full output, check exit code, count failures
4. **VERIFY** — Does output confirm the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence
5. **ONLY THEN** — Make the claim

Skip any step = lying, not verifying.

## Common Failures

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check |
| Build succeeds | Build: exit 0 | Linter passing |
| Bug fixed | Test original symptom: passes | Code changed |
| Requirements met | Line-by-line checklist | Tests passing |

## Red Flags — STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Done!", "Perfect!")
- About to commit/push/PR without verification
- Trusting agent success reports
- Relying on partial verification
