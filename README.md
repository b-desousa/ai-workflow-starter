# ai-workflow-starter

Starter de contexte pour projets AI-native — conçu pour Claude Code.

Maintenu par [b-desousa](https://github.com/b-desousa) — Architecture SI & IA.

## Philosophie

- `CLAUDE.md` est un rulebook, pas une doc. Court, stable, lu à chaque session.
- Les docs se chargent à la demande. Seul ce qui est utile à la tâche est chargé.
- Le journal remplace la mémoire perdue entre conversations.
- Ce repo ne contient pas de code. Il guide Claude Code.

## Structure

```
├── CLAUDE.md                ← Règles globales (< 80 lignes)
├── .claude/
│   ├── settings.json          ← Permissions allow/deny
│   ├── agents/                ← Subagents pour investigations isolées
│   ├── skills/                ← Workflows réutilisables
│   └── commands/              ← Raccourcis slash
└── docs/
    ├── project.md             ← Vision + scope (1 fichier)
    ├── architecture.md        ← Vue d’ensemble, intégrations, sécurité
    ├── decisions/             ← ADRs
    ├── specs/                 ← Specs de features
    └── journal/               ← Mémoire inter-sessions
```

## Usage

1. Utiliser comme template GitHub (`Use this template`)
2. Lancer le skill `project-bootstrap` dans Claude Code
3. Fermer chaque session avec `/session-close`
4. Pour les overrides perso non commis : créer `CLAUDE.local.md` (déjà dans `.gitignore`)
