# ai-workflow-starter

A Claude Code context template for solo developers. Gives Claude a structured project memory, an automated init + feature workflow, and disciplined agent behavior — with minimal token overhead.

Maintained by [b-desousa](https://github.com/b-desousa) · Architecture SI & IA.

---

## How to use this workflow

### 1. Brainstorm outside Claude Code

Do your conceptualization in any external tool (Perplexity, ChatGPT, notes, etc.).
When done, ask the AI to fill `docs/prompts/project-brief-template.md` from your conversation.
Review and correct the output.

> **Why external?** Brainstorming in Claude Code costs 20–50K tokens and produces 0 lines of code.

### 2. Clone this template and initialize the project

```bash
# GitHub → Use this template → create repo
git clone <your-new-repo>
cd <your-new-repo>
```

Open Claude Code, then:

```
/project-init [paste your filled project brief here]
```

Claude will:
1. Fill `docs/project.md` and `docs/architecture.md` from your brief
2. Create one ADR per key decision in `docs/decisions/`
3. Create ADR stubs for open questions
4. Initialize `docs/journal/session-notes.md`
5. Commit everything: `[CHORE]: initialize project from brief`
6. Print a summary of what was created and what's still open

The repo is now ready for development. No code written yet.

### 3. Implement features with /feature

For each feature, fill `docs/prompts/feature-brief-template.md` (outside Claude Code), then:

```
/feature [paste your filled feature brief here]
```

Claude will:
1. Read `docs/project.md`, `docs/architecture.md`, `docs/journal/session-notes.md`
2. Write a full implementation plan, present a task summary and wait for your approval ← **your only checkpoint**
3. Execute automatically: one subagent per task → spec review → code quality review → commit
4. Update `docs/`, create ADRs if needed, update `session-notes.md`
5. Tag the commit as `workflow/feature-*` for `/health` tracking

### 4. Investigate architecture questions with /investigate

When you need to explore the codebase without touching code — before an ADR, before a refactor, or to map dependencies:

```
/investigate <your architecture question or topic>
```

Claude will:
1. Dispatch the `architecture-investigator` agent in read-only mode
2. Return a structured report: answer + impacted files + open questions + draft ADR if a decision is needed
3. Never modify any file

> **When to use it:** codebase > ~30 files, unfamiliar zone, or before any decision that needs an ADR.

### 5. Adopt an existing project with /documentor

Starting from a repo that wasn't built with this template? Run `/documentor` once to generate the full `docs/` memory layer from the existing codebase:

```
/documentor
```

Claude will:
1. Commit the current state as a snapshot (guaranteed restore point)
2. Read the latest template structure from GitHub at runtime
3. Explore the full codebase: source files, configs, git history, existing docs
4. Generate or enrich `docs/project.md`, `docs/architecture.md`, ADRs, `session-notes.md`
5. Wire a `## Documentation map` into `CLAUDE.md` so future sessions load context automatically
6. Commit the new memory layer

> **No code is ever modified.** If `docs/` already exists, the agent enriches it without overwriting correct content.

### 6. Close every session

```
/session-close
```

Claude writes to `docs/journal/session-notes.md`: done, open, decisions, next action.
Tags the commit as `workflow/session-close-*` for `/health` tracking.
Next session, Claude reads it and resumes with full context — no re-briefing needed.

### 7. Check docs freshness with /health

If you skipped a few `/session-close` or `/feature` runs, or just want to know if docs are behind:

```
/health
```

Claude runs git-only diagnostics (~1–2K tokens): finds the last `workflow/*` tag, counts commits and changed files since, checks doc freshness. Prints a verdict — no files written.

If drift is detected:

```
/health-fix
```

Reads only the files that changed since the last workflow tag and updates the three core doc files. Much lighter than `/documentor` (~5–15K tokens).

### 8. Personal overrides (optional)

Create `CLAUDE.local.md` at root (already in `.gitignore`) for local-only context: machine paths, personal API key pointers, etc.

---

## Architecture

This template provides **no application code** — only the structure that gives Claude Code memory, rules, and an automated workflow.

```
├── CLAUDE.md                    ← Project rules + model selection, read at every session start
├── .claude/
│   ├── settings.json            ← Default model (sonnet) + tool permissions (allow/deny)
│   ├── commands/
│   │   ├── project-init.md      ← /project-init (fill docs from brief, create ADRs)
│   │   ├── feature.md           ← /feature (plan → execute → document → tag)
│   │   ├── investigate.md       ← /investigate (read-only codebase exploration, ADR prep)
│   │   ├── documentor.md        ← /documentor (adopt existing repo, generate docs/ memory)
│   │   ├── session-close.md     ← /session-close (write session journal + workflow tag)
│   │   ├── health.md            ← /health (git-only docs freshness check, ~1–2K tokens)
│   │   └── health-fix.md        ← /health-fix (targeted docs repair after /health drift)
│   ├── skills/
│   │   ├── writing-plans/       ← Atomic task plan generation
│   │   ├── subagent-driven-development/  ← Isolated subagent per task + model selection + 2-stage review
│   │   ├── verification-before-completion/  ← Evidence-before-claims gate
│   │   └── systematic-debugging/  ← Root cause before fix, 4-phase process
│   └── agents/
│       └── architecture-investigator.md  ← Wide codebase exploration without polluting main context
└── docs/
    ├── project.md               ← Vision, scope, users (filled by /project-init or /documentor)
    ├── architecture.md          ← Stack, infra, decisions (filled by /project-init or /documentor, updated auto)
    ├── decisions/               ← ADRs — created by /project-init, /documentor, and auto-created on tech choices
    ├── specs/features/          ← Feature specs — auto-created after each /feature
    ├── prompts/
    │   ├── project-brief-template.md  ← Fill externally → give to /project-init
    │   └── feature-brief-template.md  ← Fill externally → give to /feature
    └── journal/
        └── session-notes.md     ← Inter-session memory (updated by /session-close)
```

**What CLAUDE.md enforces at every session:**
- Language: English (code, comments, commits, docs)
- Commit format: `[TYPE]: description` (FEAT, FIX, REFACTOR, DOCS, TEST, CHORE, PERF, STYLE, REVERT)
- Model selection: `sonnet` default, `haiku` for mechanical tasks, `opus` for architectural decisions
- Workflow: explore → plan → implement for any change touching 2+ files
- Auto-documentation: feature spec + ADR + architecture update — silently, on every change
- Secrets: env vars only, never in source

---

## Token costs & what this template optimizes

Token cost is the real constraint of agentic development. Every session call is billed. This template is designed around minimizing waste.

### Where tokens go per command

| Phase | Tokens | Optimization lever |
|---|---|---|
| `/project-init` (one-time) | ~8–15K | Replaces N clarification exchanges with a single structured brief |
| `/documentor` (one-time on existing repos) | ~1–1.5M | Haiku for exploration (Steps 1–3), Sonnet for generation (Steps 4–7) |
| Session start (CLAUDE.md + docs load) | ~5–8K | Keep CLAUDE.md short. Only `@`-reference docs you need. |
| `/feature` plan + execution | ~60–90K (5-task feature) | Precise brief → correct plan first try → no re-generation |
| `/investigate` (on-demand) | ~3–8K | Isolated read-only pass — no context pollution |
| `/session-close` wrap-up | ~2K | Fixed, unavoidable |
| `/health` | ~1–2K | Git-only — no file reads |
| `/health-fix` | ~5–15K | Delta-only — reads only changed files since last workflow tag |

### The 3 main optimization rules

**1. Brainstorm and init outside Claude Code.**
Conceptualization + project init in Claude Code costs 50–100K tokens and produces 0 lines of code. Use external tools for brainstorming, then `/project-init` with a complete brief.

**2. Front-load context, not mid-session questions.**
Claude asking clarifying questions mid-execution means the plan was incomplete. A precise `/feature` brief eliminates 80% of mid-session interruptions and re-runs.

**3. Subagents have fresh context — by design.**
Each subagent gets only the plan + its task. It does not inherit the full session history. This keeps per-task cost flat even on long features, and prevents context window degradation on task 10+.

---

## Commands, skills & agents reference

### Commands (`/`)

| Command | Tokens | What it does |
|---|---|---|
| `/project-init <brief>` | ~8–15K | One-time init on new repos: fills all docs, creates ADRs, commits everything |
| `/documentor` | ~1–1.5M | One-time adoption of existing repos: generates docs/ memory from codebase |
| `/feature <brief>` | ~60–90K | Full workflow: plan → approval → subagent execution → docs update → workflow tag |
| `/investigate <question>` | ~3–8K | Read-only codebase exploration: answer + impacted files + risks + draft ADR |
| `/session-close` | ~2K | Write session summary to `docs/journal/session-notes.md` + workflow tag |
| `/health` | ~1–2K | Git-only docs freshness check — finds drift since last workflow tag |
| `/health-fix` | ~5–15K | Targeted docs repair — reads only changed files, updates core docs |

### Skills (auto-invoked by commands)

| Skill | Trigger | What it enforces |
|---|---|---|
| `writing-plans` | Start of `/feature` | Atomic task plan with exact file paths, exact code, exact commands — no placeholders |
| `subagent-driven-development` | After plan approval | Fresh subagent per task, model selection per task type, spec + code quality review loops |
| `verification-before-completion` | Before every commit claim | Must run and show verification command output before any success claim |
| `systematic-debugging` | On any bug or test failure | 4-phase process: root cause → pattern → hypothesis → fix. No patches without root cause. |

### Agents (invoke via command or manually)

| Agent | How to invoke | When to use |
|---|---|---|
| `architecture-investigator` | `/investigate <question>` | Wide codebase exploration to answer architecture questions or prepare an ADR |

---

## Setup

1. Go to your fork → **Settings → General → Template repository** ✓
2. **New project:** clone → `/project-init [brief]` → `/feature` → `/session-close` → repeat
3. **Existing project:** copy `.claude/` + `CLAUDE.md` into your repo → `/documentor` → `/feature` → `/session-close` → repeat
4. **Drift check anytime:** `/health` → `/health-fix` if needed
