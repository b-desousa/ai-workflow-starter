---
name: architecture-review
description: Reviews current architecture against best practices and project goals. Produces risks, gaps, and ADR candidates. Use before a major refactor or when presenting to a client.
agents: [main_agent]
---

# Architecture review skill

## 1. Load context

- Read `docs/project/vision.md`
- Read `docs/architecture/overview.md`
- Skim `docs/decisions/`

## 2. Analyze

Evaluate the current architecture on:

- **Cohesion** — are components well-separated?
- **Coupling** — are dependencies minimal and explicit?
- **Observability** — is there logging, monitoring, alerting?
- **Security** — are secrets, permissions, and surfaces managed?
- **Scalability** — where are the bottlenecks?
- **Maintainability** — will a new developer understand this in 30 min?

## 3. Output

```
## Architecture review — [date]

### Strengths
- ...

### Risks
- [HIGH/MEDIUM/LOW] Description

### ADR candidates
- Topic: ... Recommended decision: ...

### Next actions
- ...
```

## 4. Persist

Save the review output to `docs/journal/session-notes.md` with today's date.
