# Feature Brief Template

> Use this template **outside Claude Code** (Perplexity, ChatGPT, notes, etc.)  
> before running `/feature`. A precise brief = correct plan first try = 20-40% fewer tokens.

---

## How to use

1. Fill this template during your external brainstorm/planning session
2. Copy the completed brief
3. In Claude Code: `/feature [paste brief here]`

**Required minimum:** Feature goal + user story + acceptance criteria.  
**Everything else:** Fill only what you've decided. Leave blank what's still open.

---

## Brief template

```
## Feature: [short slug, e.g. "user-auth" or "pdf-export"]

## Goal
[One sentence: what this feature does and why it matters now.]

## User story
As a [type of user], I want to [action] so that [outcome].

## Acceptance criteria
- [ ] [Concrete, testable condition #1]
- [ ] [Concrete, testable condition #2]
- [ ] [Concrete, testable condition #3]

## Scope
In:
- [What is explicitly part of this feature]

Out:
- [What is explicitly NOT part of this feature — prevents scope creep]

## Technical notes (fill only what you know)
Stack / libs: [e.g. "use existing AuthService, JWT, no new deps"]
Key files likely involved: [e.g. "src/auth/, tests/auth/"]
API contract: [endpoint, method, payload shape if known]
Data model changes: [new fields, new tables, migrations if needed]
External services: [APIs, webhooks, third-party calls]
Constraints: [perf, security, backwards compat, deadlines]

## Open questions
- [Things you haven't decided yet — Claude will ask or decide with an ADR]
```

---

## What happens to open questions

If you leave **Technical notes** blank, Claude will make reasonable decisions and document them as ADRs in `docs/decisions/`.  
If you leave **Acceptance criteria** incomplete, Claude will infer them from the goal — but your plan approval is the moment to correct this.

---

## Quality checklist before running /feature

- [ ] Goal is one sentence, no vague verbs ("improve", "handle", "manage")
- [ ] Each acceptance criterion is testable by a CI check or a specific user action
- [ ] Scope OUT has at least one item (forces you to think about the boundary)
- [ ] No acceptance criterion that says "works correctly" or "is complete"

---

## Example: good vs. poor brief

**Poor** (triggers plan re-generation = wasted tokens):
```
## Feature: notifications
Add notifications to the app so users know what's happening.
```

**Good** (generates correct plan first try):
```
## Feature: email-notifications

## Goal
Send an email to the user when their export job finishes, so they don't have to poll the UI.

## User story
As a user who triggered an export, I want to receive an email when it completes so that I can close the app and come back later.

## Acceptance criteria
- [ ] Email sent within 5s of job status changing to "done" or "failed"
- [ ] Email contains a direct link to the export result
- [ ] No email sent if the user has opted out in settings
- [ ] Failed sends are retried once and logged

## Scope
In: job completion trigger, email send, opt-out check
Out: in-app notification bell, SMS, push notifications

## Technical notes
Stack: use existing JobService event system, add Resend as email provider
Key files: src/jobs/, src/notifications/ (new), src/users/preferences
Data model: add email_notifications boolean to user_preferences table
Constraints: must not block the job completion response (fire-and-forget)
```
