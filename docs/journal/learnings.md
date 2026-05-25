# Learnings

> Patterns, mistakes, and discoveries worth keeping — architecture de savoir personnel.
> Each entry can become a conseil d'architecture ou un article.

---

## 2026-05-25 — Claude Code context management

**Pattern**: Split documentation into stable layers (global rules, architecture, decisions, specs, journal) and load only the relevant layer per task.

**Why it matters**: A monolithic `context.md` increases token cost, degrades over time, and gets ignored when too long.

**Rule**: CLAUDE.md = rules only. Architecture = load on demand. Session memory = journal.
