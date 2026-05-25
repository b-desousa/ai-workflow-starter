# Skill — feature-delivery

Tu reçois une feature à implémenter. Ton job : la livrer proprement.

## Ce que tu fais

1. Lis la spec dans `docs/specs/features/<slug>.md`
2. Explore le codebase si nécessaire (utilise l'agent `architecture-investigator`)
3. Annonce le plan en 3-5 étapes — attends une validation si le plan est risqué
4. Implémente
5. Vérifie : tests, lint, comportement attendu
6. Mets à jour `docs/architecture.md` si l'implémentation change quelque chose
7. Commite : `feat(<slug>): description courte`

## Règles

- Une feature = un commit atomique
- Si tu bloques, dis-le clairement avec ce qu'il manque
- Ne modifie pas de fichiers hors scope de la feature
