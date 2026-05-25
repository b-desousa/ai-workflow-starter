# Runbook — Production (Hetzner VPS + Coolify)

## Deploy

```bash
bash scripts/deploy.sh
```

Or: push to `main` if Coolify auto-deploy is configured.

## Check status

```bash
# On VPS:
docker ps
docker logs <container-name> --tail 50
```

## Rollback

Coolify UI → Deployments tab → select previous build → Redeploy.

Document rollback in this file under **Incident log**.

## Incident log

| Date | Issue | Action | Resolved by |
|---|---|---|---|
| | | | |

## Access

- Coolify dashboard: `https://<your-coolify-url>`
- VPS SSH: `ssh root@<vps-ip>`
