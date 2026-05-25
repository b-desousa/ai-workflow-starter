# ai-workflow-starter

Starter repo for AI-native software projects — designed for Claude Code, clean architecture, and demonstrable engineering practice.

Maintained by [b-desousa](https://github.com/b-desousa) — Architecture SI & IA.

## Philosophy

- **Minimal root context** — CLAUDE.md is a rulebook, not a documentation dump.
- **Progressive disclosure** — load only the context you need for the task at hand.
- **Documented practice** — every decision, every deployment, every learning is written down.
- **AI-native by default** — structure designed for Claude Code skills, subagents, and low-token workflows.

## Quick start

```bash
cp CLAUDE.local.md.example CLAUDE.local.md
bash scripts/bootstrap.sh
```

## Structure

```
├── CLAUDE.md                  ← Global rules for Claude Code (keep short)
├── CLAUDE.local.md.example    ← Personal overrides template (not committed)
├── .claude/
│   ├── settings.json
│   ├── agents/                ← Subagent definitions
│   └── skills/                ← Reusable Claude Code skills
├── docs/
│   ├── project/               ← Vision, scope, glossary
│   ├── architecture/          ← Architecture by topic
│   ├── decisions/             ← ADRs (Architecture Decision Records)
│   ├── specs/                 ← Feature specs
│   ├── operations/            ← Runbooks, deploy guides
│   └── journal/               ← Session notes, learnings
├── scripts/                   ← bootstrap, test, lint, deploy
├── infra/                     ← Docker, Coolify, compose
├── src/
├── tests/
└── .github/workflows/
```
