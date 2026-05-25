# ai-workflow-starter

Starter de contexte pour projets AI-native — conçu pour Claude Code.

Maintenu par [b-desousa](https://github.com/b-desousa) — Architecture SI & IA.

## Philosophie

- **Contexte minimal** — `CLAUDE.md` est un rulebook, pas une doc.
- **Chargement progressif** — on charge uniquement ce qui est utile à la tâche en cours.
- **Mémoire inter-sessions** — le journal remplace le contexte perdu entre conversations.
- **Pas d’infra ici** — scripts, Docker, CI/CD appartiennent au repo projet réel.

## Structure

```
├── CLAUDE.md                   ← Règles globales Claude Code (< 80 lignes)
├── CLAUDE.local.md.example     ← Overrides personnels (non commis)
├── .claude/
│   ├── settings.json             ← Permissions allow/deny
│   ├── agents/                   ← Subagents pour investigations isolées
│   ├── skills/                   ← Workflows réutilisables
│   └── commands/                 ← Raccourcis slash
└── docs/
    ├── project/                  ← Vision, scope, glossaire
    ├── architecture/             ← Vue d’ensemble, intégrations, sécurité
    ├── decisions/                ← ADRs
    ├── specs/                    ← Specs de features
    └── journal/                  ← Notes de sessions, learnings
```

## Usage

1. Utiliser ce repo comme template GitHub
2. Remplir `docs/project/vision.md` et `scope.md`
3. Lancer le skill `project-bootstrap` dans Claude Code
4. Fermer chaque session avec `/session-close`
