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
2. Write a full implementation plan → `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`
3. Present a task summary and wait for your approval ← **your only checkpoint**
4. Execute automatically: one subagent per task → spec review → code quality review → commit
5. Update `docs/`, create ADRs if needed, update `session-notes.md`

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

### 5. Close every session

```
/session-close
```

Claude writes to `docs/journal/session-notes.md`: done, open, decisions, next action.
Next session, Claude reads it and resumes with full context — no re-briefing needed.

### 6. Personal overrides (optional)

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
│   │   ├── feature.md           ← /feature (plan → execute → document)
│   │   ├── investigate.md       ← /investigate (read-only codebase exploration, ADR prep)
│   │   └── session-close.md     ← /session-close (write session journal)
│   ├── skills/
│   │   ├── writing-plans/       ← Atomic task plan generation
│   │   ├── subagent-driven-development/  ← Isolated subagent per task + model selection + 2-stage review
│   │   ├── verification-before-completion/  ← Evidence-before-claims gate
│   │   └── systematic-debugging/  ← Root cause before fix, 4-phase process
│   └── agents/
│       └── architecture-investigator.md  ← Wide codebase exploration without polluting main context
└── docs/
    ├── project.md               ← Vision, scope, users (filled by /project-init)
    ├── architecture.md          ← Stack, infra, decisions (filled by /project-init, updated auto)
    ├── decisions/               ← ADRs — created by /project-init and auto-created on tech choices
    ├── specs/features/          ← Feature specs — auto-created after each /feature
    ├── superpowers/plans/       ← Implementation plans — auto-created by /feature
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
| Session start (CLAUDE.md + docs load) | ~2K | Keep CLAUDE.md short. Only `@`-reference docs you need. |
| `/feature` plan generation | ~5–10K | A precise brief → correct plan first try → no re-generation |
| `/investigate` (on-demand) | ~3–8K | Isolated read-only pass — no context pollution, no wasted implementation tokens |
| Per task: implementation subagent | ~5–10K | Fresh context = no history baggage. `haiku` for mechanical tasks. |
| Per task: spec + code quality review | ~6–10K | `sonnet` for both, `opus` only for final cross-cutting review |
| `/session-close` wrap-up | ~2K | Fixed, unavoidable |
| **Total for a 5-task feature** | **~60–90K tokens** | |

### The 3 main optimization rules

**1. Brainstorm and init outside Claude Code.**
Conceptualization + project init in Claude Code costs 50–100K tokens and produces 0 lines of code. Use external tools for brainstorming, then `/project-init` with a complete brief.

**2. Front-load context, not mid-session questions.**
Claude asking clarifying questions mid-execution means the plan was incomplete. A precise `/feature` brief eliminates 80% of mid-session interruptions and re-runs.

**3. Subagents have fresh context — by design.**
Each subagent gets only the plan + its task. It does not inherit the full session history. This keeps per-task cost flat even on long features, and prevents context window degradation on task 10+.

### What grows your bill fast
- Keeping Claude in conversation for exploration/discovery (use docs + external tools instead)
- Large files in context (keep functions small, files focused)
- Repeated failed tasks without a plan (no plan = no subagent = full-context re-runs)
- Re-generating plans due to vague briefs

---

## Commands, skills & agents reference

### Commands (`/`)

| Command | What it does |
|---|---|
| `/project-init <brief>` | One-time init: fills all docs, creates ADRs, commits everything |
| `/feature <brief>` | Full workflow: generate plan → human approval → subagent execution → docs update |
| `/investigate <question>` | Read-only codebase exploration: answer + impacted files + risks + draft ADR |
| `/session-close` | Write session summary to `docs/journal/session-notes.md` |

### Skills (auto-invoked by commands)

| Skill | Trigger | What it enforces |
|---|---|---|
| `writing-plans` | Start of `/feature` | Atomic task plan with exact file paths, exact code, exact commands — no placeholders |
| `subagent-driven-development` | After plan approval | Fresh subagent per task, model selection per task type, spec + code quality review loops |
| `verification-before-completion` | Before every commit claim | Must run and show verification command output before any success claim |
| `systematic-debugging` | On any bug or test failure | 4-phase process: root cause → pattern → hypothesis → fix. No patches without root cause. |

### Agents (invoke via `/investigate` or manually)

| Agent | How to invoke | When to use |
|---|---|---|
| `architecture-investigator` | `/investigate <question>` | Wide codebase exploration to answer architecture questions, map dependencies, or prepare an ADR — without polluting the main session context |

### Prompts (`docs/prompts/`)

| Template | When to use |
|---|---|
| `project-brief-template.md` | Fill externally after brainstorm → paste into `/project-init` |
| `feature-brief-template.md` | Fill externally before each feature → paste into `/feature` |

---

## Setup

1. Go to your fork → **Settings → General → Template repository** ✓
2. For each new project: clone → `/project-init [brief]` → `/feature` → `/session-close` → repeat
