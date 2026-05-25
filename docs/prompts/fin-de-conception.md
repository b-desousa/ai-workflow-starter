# Prompt — Fin de session de conceptualisation

> À utiliser dans **Mammouth** ou **Perplexity** à la fin d'une session de conception.  
> Le résumé produit est directement donné à Claude Code, qui initialise le repo.

---

## Prompt à copier

```
Nous venons de terminer notre session de conceptualisation.

Fais-moi un résumé complet et structuré de tout ce qu'on a décidé,
dans le format suivant — sans omettre d'information utile,
sans ajouter de remplissage :

---
## Nom du projet
[nom]

## Vision
[ce que c'est, pour qui, pourquoi — 2-3 phrases]

## Objectif court terme
[ce qui doit fonctionner en priorité]

## Utilisateurs / client
[qui utilise, quel contexte]

## Features v1
[liste des features décidées, une par ligne]

## Hors scope v1
[ce qu'on a explicitement exclu]

## Stack technique
[technos, services, APIs décidés ou envisagés]

## Infrastructure
[déploiement, hébergement, domaine, Docker, etc.]

## Intégrations externes
[APIs tierces, webhooks, services connectés]

## Contraintes
[délais, budget, limites techniques]

## Décisions clés
[choix importants avec leur justification courte]

## Points de vigilance
[risques, incertitudes, choses à valider]
---
```

---

## Ensuite : injection dans Claude Code

Colle le résumé dans Claude Code avec cette instruction :

```
Voici le résumé de ma session de conceptualisation.
Initialise le projet en lançant le skill project-bootstrap.

[coller le résumé ici]
```

Claude Code s'occupe du reste.
