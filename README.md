# ai-workflow-starter

Starter de contexte pour projets AI-native — conçu pour Claude Code.

Maintenu par [b-desousa](https://github.com/b-desousa) — Architecture SI & IA.

## Philosophie

- `CLAUDE.md` est un rulebook, pas une doc. Court, stable, lu à chaque session.
- Les docs se chargent à la demande. Seul ce qui est utile à la tâche est chargé.
- Le journal remplace la mémoire perdue entre sessions.
- Ce repo ne contient pas de code. Il guide Claude Code.

## Structure

```
├── CLAUDE.md                ← Règles globales (< 80 lignes)
├── .claude/
│   ├── settings.json        ← Permissions allow/deny
│   ├── agents/              ← Subagents pour investigations isolées
│   ├── skills/              ← Workflows structurés
│   └── commands/            ← Raccourcis slash
└── docs/
    ├── project.md           ← Vision + scope
    ├── architecture.md      ← Vue d'ensemble, intégrations, sécurité
    ├── decisions/           ← ADRs (auto-générés)
    ├── specs/               ← Specs de features (auto-générées)
    ├── prompts/             ← Prompts réutilisables
    └── journal/             ← Mémoire inter-sessions
```

---

## Chaîne de travail

```
CONCEPTION                INITIALISATION        EXÉCUTION              RÉFLEXION
──────────────────────    ──────────────        ──────────────         ──────────────
Mammouth / Perplexity     Claude Code           Claude Code            Perplexity
                                                                       + GitHub connector
Explorer, arbitrer        Reçoit le résumé      Implémente             Lit le repo
Prompt fin-de-            Remplit les docs      Documente auto         Génère un prompt
conception ↓              Crée ADRs + specs     /session-close         → Claude Code
Résumé structuré          Commite tout          /ship
```

**Règle d'or** : ne lance Claude Code que sur quelque chose d'écrit dans le repo.

| Outil | Rôle |
|---|---|
| **Mammouth** | Concevoir, arbitrer, produire le résumé de fin de session |
| **Perplexity** | Veille tech, vérification de décisions, générer des prompts Claude Code |
| **Claude Code** | Tout ce qui touche les fichiers du repo — init, implémentation, commit |

---

## Démarrer un projet

### Étape 1 — Concevoir (Mammouth / Perplexity)

Une fois ta session de conceptualisation terminée, colle ce prompt :

```
Nous venons de terminer notre session de conceptualisation.

Fais-moi un résumé complet et structuré de tout ce qu'on a décidé,
dans le format suivant — sans omettre d'information utile, sans remplissage :

## Nom du projet
## Vision
## Objectif court terme
## Utilisateurs / client
## Features v1
## Hors scope v1
## Stack technique
## Infrastructure
## Intégrations externes
## Contraintes
## Décisions clés
## Points de vigilance
```

### Étape 2 — Initialiser (Claude Code)

1. `GitHub → Use this template → créer le repo projet`
2. Ouvrir Claude Code dans le repo
3. Coller :

```
Voici le résumé de ma session de conceptualisation.
Initialise le projet en lançant le skill project-bootstrap.

[résumé ici]
```

Claude remplit `docs/project.md`, `docs/architecture.md`, crée les ADRs et specs, commite tout.

---

## Cycle de développement

**Implémenter** : décris ce que tu veux en langage naturel. Claude implémente, documente les specs et ADRs concernés, commite — automatiquement.

**Fermer la session** : `/session-close` — Claude écrit dans `docs/journal/session-notes.md` : fait / reste / décisions / prochaine action.

**Reprendre** : `CLAUDE.md` + `docs/journal/session-notes.md` — le contexte est là.

---

## Référence rapide

| Commande | Usage |
|---|---|
| `/project-bootstrap` | Initialiser depuis un brief |
| `/session-close` | Journal de fin de session |
| `/ship` | Lint + test + deploy |

| Agent | Usage |
|---|---|
| `architecture-investigator` | Explorer le codebase en isolation |
| `reviewer` | Revue structurée avant `/ship` |

---

## Setup

**Activer le template** : Settings → General → Template repository ✓

**Overrides personnels** : créer `CLAUDE.local.md` à la racine (dans `.gitignore`) pour du contexte local non commité.
