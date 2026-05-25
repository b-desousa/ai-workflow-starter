# ADR-002 — Gestion du contexte Claude Code

## Status

`accepted`

## Date

2026-05-25

## Context

L'usage d'un seul `context.md` monolithique passé à chaque session Claude Code entraîne : une consommation de tokens élevée, une perte de contexte après saturation de conversation, et une maintenance difficile.

## Decision

Le contexte est découpé en couches :

- `CLAUDE.md` : règles globales ultra-stables, < 100 lignes.
- `docs/architecture/` : chargé à la demande par sujet.
- `docs/decisions/` : ADRs pour les décisions structurantes.
- `docs/specs/features/` : specs détaillées par feature.
- `docs/journal/` : mémoire compressée inter-sessions.
- `.claude/skills/` : workflows réutilisables.
- `.claude/agents/` : investigations isolées via subagents.

## Consequences

- Réduit la consommation de tokens par session.
- Améliore la continuité inter-sessions via le journal.
- Nécessite une discipline de mise à jour des docs après chaque session.

## Alternatives considered

- `context.md` unique : simple mais trop lourd et fragile.
- Prompts ad hoc sans structure : rapide mais non maintenable.

## Tags

`[AI]` `[COST]`
