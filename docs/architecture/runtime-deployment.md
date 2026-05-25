# Runtime & deployment

## Hosting

- Provider: Hetzner VPS cax11 (2 vCPU / 4 GB RAM)
- Orchestration: Docker + Coolify

## Services

| Service | Port | Notes |
|---|---|---|
| n8n | 5678 | Automation workflows |
| App | | |

## Environment variables

See `.env.example` at project root.

## Deployment flow

1. Push to `main`
2. Coolify webhook triggers build
3. Docker image built and deployed
4. Health check confirms service is up

## Rollback

Coolify UI → Deployments → select previous → Redeploy.
