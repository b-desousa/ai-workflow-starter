# Sécurité

## Principes

- Secrets en variables d’environnement uniquement.
- Moindre privilège sur toutes les intégrations externes.
- Aucun endpoint public sans auth.

## Checklist avant deploy

- [ ] Aucun secret en clair dans le source
- [ ] `.env.example` à jour
- [ ] Ports exposés passés en revue
- [ ] Dépendances à jour
