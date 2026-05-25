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
│   ├── settings.json        ← Permissions allow/deny
│   ├── agents/              ← Subagents pour investigations isolées
│   ├── skills/              ← Workflows réutilisables
│   └── commands/            ← Raccourcis slash
└── docs/
    ├── project.md           ← Vision + scope (1 fichier)
    ├── architecture.md      ← Vue d'ensemble, intégrations, sécurité
    ├── decisions/           ← ADRs
    ├── specs/               ← Specs de features
    └── journal/             ← Mémoire inter-sessions
```

## Workflow projet

### 1. Démarrer un projet

```
GitHub → Use this template → créer le repo projet
```

Ouvrir Claude Code dans le repo, puis :

```
/project-bootstrap
```

Claude remplit `docs/project.md`, `docs/architecture.md`, et crée le premier ADR stack.

---

### 2. Cadrer une feature

Créer `docs/specs/features/<feature-slug>.md` depuis le template.  
Ou demander à Claude : *"Crée une spec pour [feature] depuis le template"*.

---

### 3. Implémenter

```
/feature-delivery
```

Claude lit la spec, explore le codebase, planifie, implémente, vérifie, documente.

---

### 4. Fermer la session

```
/session-close
```

Claude écrit un résumé dans `docs/journal/session-notes.md` :
ce qui a été fait, ce qui reste, les décisions prises, la prochaine action.

---

### 5. Reprendre un projet

Ouvrir Claude Code → le contexte est dans `CLAUDE.md` (règles) + `docs/journal/session-notes.md` (dernière session).  
Pas besoin de réexpliquer tout le projet.

---

### Commandes disponibles

| Commande | Usage |
|---|---|
| `/project-bootstrap` | Initialiser un nouveau projet |
| `/feature-delivery` | Implémenter une feature de bout en bout |
| `/session-close` | Écrire le journal de fin de session |
| `/ship` | Lint + test + deploy en séquence |

### Agents disponibles

| Agent | Usage |
|---|---|
| `architecture-investigator` | Explorer le codebase sans polluer le contexte principal |
| `reviewer` | Revue structurée d'un diff ou d'une PR |

---

## Activer comme template

Dans GitHub : **Settings → General → Template repository** ✓  
Ensuite : **Use this template** pour chaque nouveau projet.

## Overrides personnels

Créer `CLAUDE.local.md` à la racine (déjà dans `.gitignore`) pour des notes perso non committées : contexte local, préférences, focus en cours.
