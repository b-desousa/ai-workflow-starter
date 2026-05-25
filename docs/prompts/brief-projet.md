# Prompt — Brief projet pour initialisation Claude Code

> Utiliser dans **Mammouth** ou **Perplexity** en début de projet.  
> Coller ce prompt, remplacer les `[...]`, laisser l’IA compléter les deux blocs.  
> Donner ensuite les deux blocs à Claude Code en une seule instruction.

---

## Prompt à copier

```
Je démarre un nouveau projet. Je vais te donner le contexte, et tu vas produire
exactement deux blocs de contenu prêts à injecter dans mon repo GitHub.

## Contexte du projet

Nom : [nom du projet]
Objectif principal : [ce que le projet doit accomplir]
Utilisateurs / client : [qui va utiliser ça]
Stack technique envisagée : [langages, frameworks, services]
Contraintes : [délais, budget, limitations techniques]
Déploiement : [VPS Hetzner cax11, Coolify, Docker — ou autre]

Features principales prévues :
- [feature 1]
- [feature 2]
- [feature 3]

## Ta mission

Produis exactement ces deux blocs, dans ce format :

---
[BLOC 1 — docs/project.md]

# [Nom du projet]

## Vision
[1-2 phrases : ce que c’est, pour qui, pourquoi]

## Objectif 4 semaines
[Ce qui doit fonctionner en production dans 4 semaines]

## Utilisateurs cibles
[Description courte]

## Périmètre v1
[Liste des features incluses dans la v1]

## Hors scope v1
[Ce qu’on ne fait pas dans la v1]

## Critères de succès
[3-5 critères mesurables]

## Contraintes
[Techniques, temporelles, financières]

---
[BLOC 2 — docs/architecture.md]

# Architecture — [Nom du projet]

## Vue d’ensemble
[Schéma texte ou description des composants principaux et de leurs interactions]

## Stack technique
| Couche | Technologie | Justification |
|---|---|---|
| ... | ... | ... |

## Infrastructure
[Déploiement, serveur, Docker, domaine, reverse proxy]

## Intégrations externes
[APIs, services tiers, webhooks]

## Sécurité
[Auth, secrets, exposition réseau]

## Décisions techniques clés
[2-4 choix importants avec justification courte]

## Points de vigilance
[Risques techniques, dettes potentielles, à surveiller]
---

Sois précis, concis, opérationnel. Pas de remplissage. Chaque ligne doit
être utile à un développeur qui reprend le projet à froid.
```

---

## Injection dans Claude Code

Une fois Mammouth / Perplexity a répondu, donner à Claude Code :

```
Lis ce brief. Remplis docs/project.md et docs/architecture.md avec le contenu
ci-dessous, crée un ADR stack dans docs/decisions/, une spec pour chaque feature
de la v1 dans docs/specs/features/, commite tout en un seul commit.

[coller BLOC 1]

[coller BLOC 2]
```
