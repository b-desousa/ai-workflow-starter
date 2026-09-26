# ai-workflow-starter

A lean, spec-driven workflow for building software with Claude: plan anywhere (web, mobile), execute in Claude Code, keep every decision traceable in the repo.

> Using this as a template? Replace this README with your project's own once it starts.

## The idea

- **The repo is the source of truth.** Decisions never live only in a chat: they land in `docs/` as specs and ADRs.
- **Chat decides, Claude Code executes.** Planning is cheap conversation; execution only starts on an approved spec.
- **Lean by default.** No required docs, no placeholders, no framework to install. Files appear only when they have content.

## The loop

1. **Plan (chat, web or mobile).** `/spec new` explores an idea, then writes a `draft` spec in `docs/specs/`. `/spec review` resolves its open questions. You approve: the spec becomes `ready`.
2. **Execute (Claude Code).** `/spec run NNN` implements one `ready` spec test-first (acceptance tests written and failing before any code), then opens one pull request. `/spec run all` does every `ready` spec in a single pull request.
3. **Close the loop (chat).** `/spec review` on anything the run sent back: specs returned to `draft`, ADRs `proposed`. You review and merge the PRs.

| Spec status | Meaning |
|---|---|
| `draft` | Being discussed, or sent back with an open question |
| `ready` | Approved by you: the only way execution starts |
| `in-progress` | Claimed by `/spec run` |
| `done` | Implemented, pull request opened |

When the agent must make a decision the spec did not cover, it judges by the cost of being wrong: cheap to undo → noted in the PR; costly with a sensible default → ADR `proposed` for your review; depends on product intent → spec back to `draft` with a question.

## What's in the repo

| File | Role |
|---|---|
| `CLAUDE.md` | The only always-loaded context: project line, commands, a few non-negotiable rules |
| `.claude/hooks/board.sh` + `.claude/settings.json` | At session start, lists specs not done and ADRs `proposed` |
| `docs/specs/`, `docs/adr/` | Created on demand by `/spec` |

Formats and the full workflow live in the **`/spec` skill**, saved at account level on claude.ai (one copy for every project). Spec acceptance criteria use [EARS](https://alistairmavin.com/ears/) notation; ADRs follow a light [MADR](https://adr.github.io/madr/).

## Getting started

1. Create a repo from this template.
2. Make sure the `/spec` skill is enabled on your Claude account and the GitHub connector can reach the repo. If your local Claude Code CLI does not see the skill, download it into `~/.claude/skills/spec/`.
3. First Claude Code session: fill the project line and commands in `CLAUDE.md`.
4. Plan your first feature from the chat with `/spec new`.
