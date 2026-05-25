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

---

## Chaîne de travail IA

Ce workflow répartit chaque outil selon son rôle — aucun copier-coller de fichiers, aucune friction manuelle.

```
CONCEPTION              INITIALISATION          EXÉCUTION               RÉFLEXION
────────────────        ────────────────        ────────────────        ────────────────
Mammouth / Perplexity   Claude Code             Claude Code             Perplexity
                                                                        + connecteur GitHub

Explorer                Reçoit le brief         /feature-delivery       Lit le repo
Arbitrer                Remplit les docs        /session-close          Génère un prompt
Rédiger le brief        Crée ADRs + specs       /ship                   → Claude Code
                        Commite tout
```

### Règle d'or

> Ne lance Claude Code que sur quelque chose d'**écrit dans le repo**.  
> Si tu ne peux pas pointer vers un fichier dans `docs/`, tu es encore en phase conception.

### Ce que tu fais dans chaque outil

| Outil | Usage |
|---|---|
| **Mammouth** | Explorer, arbitrer, rédiger le brief projet (→ `docs/project.md` + `docs/architecture.md`) |
| **Perplexity** | Veille tech, vérification de décisions, génération de prompts Claude Code depuis le repo |
| **Claude Code** | Tout ce qui touche le code et les fichiers du repo — initialisation, implémentation, commit |

### Entrée dans Claude Code

Mammouth produit un **brief structuré en deux blocs** (voir prompt ci-dessous).  
Tu le donnes à Claude Code en une instruction :

```
Lis ce brief. Remplis docs/project.md et docs/architecture.md avec le contenu ci-dessous,
crée les ADRs et specs correspondants, commite tout.

[BLOC 1 — docs/project.md]
...

[BLOC 2 — docs/architecture.md]
...
```

Claude écrit, commite. Toi tu valides ou tu corriges en langage naturel.

---

## Workflow projet

### 1. Concevoir (Mammouth / Perplexity)

Utiliser le prompt de brief disponible dans [`docs/prompts/brief-projet.md`](docs/prompts/brief-projet.md).  
Mammouth produit les deux blocs de contenu prêts à injecter.

### 2. Initialiser (Claude Code)

```
GitHub → Use this template → créer le repo projet
```

Donner le brief à Claude Code → il remplit les docs, crée ADRs et specs, commite.

### 3. Cadrer une feature

Demander à Claude Code : *"Crée une spec pour [feature] depuis le template dans `docs/specs/features/`"*.

### 4. Implémenter

```
/feature-delivery
```

Claude lit la spec, explore, planifie (tu valides), implémente, vérifie, documente.

### 5. Fermer la session

```
/session-close
```

Claude écrit dans `docs/journal/session-notes.md` : fait / reste / décisions / prochaine action.

### 6. Reprendre un projet

Ouvrir Claude Code → `CLAUDE.md` (règles) + `docs/journal/session-notes.md` (dernière session).  
Pas besoin de réexpliquer le projet.

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
