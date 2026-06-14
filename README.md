# ai-workflow-starter

A Claude Code context template for solo developers. Gives Claude a structured project memory, an automated feature workflow, and disciplined agent behavior — with minimal token overhead.

Maintained by [b-desousa](https://github.com/b-desousa) · Architecture SI & IA.

---

## How to use this workflow

### 1. Create your project from this template

```bash
# GitHub → Use this template → create repo
git clone <your-new-repo>
cd <your-new-repo>
```

Fill in the two required files before opening Claude Code:

- `docs/project.md` — project vision, scope, target users, v1 features, out-of-scope
- `docs/architecture.md` — stack, infrastructure, key integrations, constraints

### 2. Brainstorm outside Claude Code

Do your conceptualization and planning in any external tool (Perplexity, ChatGPT, notes, etc.).
Do **not** use Claude Code for brainstorming — it consumes tokens without producing code.

### 3. Open Claude Code and launch a feature

```
/feature <your feature description or structured brief>
```

Claude will:
1. Read `CLAUDE.md`, `docs/project.md`, `docs/architecture.md`, `docs/journal/session-notes.md`
2. Write a full implementation plan → `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`
3. Present a task summary and wait for your approval ← **your only checkpoint**
4. Execute automatically: subagent per task → spec review → code quality review → commit
5. Update `docs/`, create ADRs if needed, update `session-notes.md`

### 4. Close the session

```
/session-close
```

Claude writes the session summary to `docs/journal/session-notes.md` (done, open, decisions, next action).
Next session, Claude reads it and resumes with full context.

### 5. Add a CLAUDE.local.md for personal overrides (optional)

Create `CLAUDE.local.md` at root (already in `.gitignore`) for local-only context: machine paths, personal API keys pointers, etc.

---

## Architecture

This template provides **no application code** — only the structure that gives Claude Code memory, rules, and an automated workflow.

```
├── CLAUDE.md                    ← Project rules read at every session start
├── .claude/
│   ├── settings.json            ← Tool permissions (allow/deny)
│   ├── commands/
│   │   └── feature.md           ← /feature command (plan → execute → document)
│   ├── skills/
│   │   ├── writing-plans/       ← Atomic task plan generation
│   │   ├── subagent-driven-development/  ← Isolated subagent per task + 2-stage review
│   │   ├── verification-before-completion/  ← Evidence-before-claims gate
│   │   └── systematic-debugging/  ← Root cause before fix, 4-phase process
│   └── agents/                  ← Reserved for future investigation agents
└── docs/
    ├── project.md               ← Vision, scope, users (fill on init)
    ├── architecture.md          ← Stack, infra, decisions (fill on init, updated auto)
    ├── decisions/               ← ADRs — auto-created on significant tech choices
    ├── specs/features/          ← Feature specs — auto-created after each /feature
    ├── superpowers/plans/       ← Implementation plans — auto-created by /feature
    ├── prompts/                 ← Reusable prompts
    └── journal/
        └── session-notes.md     ← Inter-session memory (updated by /session-close)
```

**What CLAUDE.md enforces at every session:**
- Language: English (code, comments, commits, docs)
- Commit format: `[TYPE]: description` (FEAT, FIX, REFACTOR, DOCS, TEST, CHORE, PERF, STYLE, REVERT)
- Workflow: explore → plan → implement for any change touching 2+ files
- Auto-documentation: feature spec + ADR + architecture update — silently, on every change
- Secrets: env vars only, never in source

---

## Token costs & what this template optimizes

Token cost is the real constraint of agentic development. Every session call is billed. This template is designed around minimizing waste.

### Where tokens go in a /feature run

| Phase | Tokens | Optimization lever |
|---|---|---|
| Session start (CLAUDE.md + docs load) | ~2K | Keep CLAUDE.md short. Only `@`-reference docs you need. |
| Plan generation | ~5–10K | A precise /feature brief → correct plan first try → no re-generation |
| Per task: implementation subagent | ~5–10K | Cheap/fast model for mechanical tasks (1-2 files, clear spec) |
| Per task: spec compliance review | ~3–5K | Standard model |
| Per task: code quality review | ~3–5K | Standard model |
| Wrap-up (docs + session-notes) | ~2K | Fixed, unavoidable |
| **Total for a 5-task feature** | **~60–90K tokens** | |

### The 3 main optimization rules

**1. Brainstorm outside Claude Code.**
A brainstorming session with Claude consumes 20–50K tokens and produces 0 lines of code. Use any external tool instead.

**2. Front-load context, not mid-session questions.**
Claude asking clarifying questions mid-execution means the plan was incomplete. A precise /feature brief eliminates 80% of mid-session interruptions and re-runs.

**3. Subagents have fresh context — by design.**
Each subagent gets only the plan + its task. It does not inherit the full session history. This keeps per-task cost flat even on long features, and prevents context window degradation on task 10+.

### What grows your bill fast

- Keeping Claude in the conversation for exploration/discovery (use docs + external tools instead)
- Large files in context (keep functions small, files focused)
- Repeated failed tasks without a plan (no plan = no subagent = full-context re-runs)
- Re-generating plans due to vague briefs

---

## Commands, skills & agents reference

### Commands (`/`)

| Command | What it does |
|---|---|
| `/feature <brief>` | Full workflow: generate plan → human approval → subagent execution → docs update |
| `/session-close` | Write session summary to `docs/journal/session-notes.md` |

### Skills (auto-invoked by `/feature`)

| Skill | Trigger | What it enforces |
|---|---|---|
| `writing-plans` | Start of `/feature` | Atomic task plan with exact file paths, exact code, exact commands — no placeholders |
| `subagent-driven-development` | After plan approval | Fresh subagent per task, continuous execution, spec + code quality review loops |
| `verification-before-completion` | Before every commit claim | Must run and show verification command output before any success claim |
| `systematic-debugging` | On any bug or test failure | 4-phase process: root cause → pattern → hypothesis → fix. No patches without root cause. |

### Agents (`agents/`)

| Agent | Purpose |
|---|---|
| *(reserved)* | Add investigation agents here for large codebase exploration tasks |

---

## Setup

1. Go to your fork → **Settings → General → Template repository** ✓
2. Fill `docs/project.md` and `docs/architecture.md` before the first session
3. Run `/feature` for every new feature. Run `/session-close` at the end of every session.
