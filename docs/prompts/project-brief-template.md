# Project Brief Template

> Use this template **outside Claude Code** at the end of your brainstorm/conceptualization session.  
> Ask your external AI (Perplexity, ChatGPT, etc.): *"Fill this template based on everything we just discussed."*  
> Then paste the output into Claude Code with `/project-init [paste here]`.

---

## How to use

1. Finish your brainstorm session in any external tool
2. Paste this template and ask the AI to fill it from your conversation
3. Review the output — correct anything wrong
4. In Claude Code (fresh clone of ai-workflow-starter): `/project-init [paste filled template]`

---

## Project brief template

```
## Project name
[slug and display name]

## Vision
[What it is, for whom, and why it matters — 2-3 sentences max]

## Short-term objective
[What must work first — the v1 north star]

## Users
[Who uses this, in what context, what is their main pain point]

## Features v1
[Exhaustive list of features decided for v1, one per line]

## Out of scope v1
[What is explicitly excluded — prevents scope creep from day one]

## Tech stack
[Languages, frameworks, libraries, databases decided or strongly considered]

## Infrastructure
[Deployment target, hosting, containerization, CI/CD, domain]

## External integrations
[Third-party APIs, webhooks, services, auth providers]

## Constraints
[Deadlines, budget, team size, technical limits, compliance]

## Key decisions
[Important choices already made, each with a one-line rationale]

## Open questions
[Things not yet decided — Claude will create ADRs for these]

## Risk & watch points
[Known risks, technical uncertainties, things to validate early]
```

---

## What /project-init does with this brief

1. Fills `docs/project.md` from Vision + Users + Features + Out of scope
2. Fills `docs/architecture.md` from Stack + Infrastructure + Integrations + Constraints
3. Creates one ADR per Key decision in `docs/decisions/`
4. Creates one ADR stub per Open question (status: proposed)
5. Commits everything: `[CHORE]: initialize project from brief`
6. Prints a summary of what was created and what open questions need your decision

After this, the repo is ready for `/feature`.
