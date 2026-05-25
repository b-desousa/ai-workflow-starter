# Security

## Principles

- Secrets in env vars only, never in source.
- Least privilege on all external integrations.
- No public endpoints without auth.

## Secrets management

- Local: `.env` (gitignored)
- Production: Coolify environment variables

## Access control

| Resource | Who has access |
|---|---|
| VPS | Owner only |
| Coolify | Owner only |
| n8n | Owner only |

## Security checklist before deploy

- [ ] No secrets in source (grep check in `deploy-coolify` skill)
- [ ] `.env.example` up to date
- [ ] Exposed ports reviewed
- [ ] Dependencies up to date
