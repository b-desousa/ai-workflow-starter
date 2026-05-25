# Runbook — Dev environment

## Prerequisites

- Docker Desktop or Docker Engine
- Node.js (version from `.nvmrc` or `package.json`)
- `.env` filled from `.env.example`

## Start

```bash
bash scripts/bootstrap.sh
npm run dev
```

## Common issues

| Issue | Fix |
|---|---|
| Port already in use | `lsof -ti:<port> | xargs kill` |
| Env var missing | Check `.env.example` for new variables |
| Docker not running | Start Docker Desktop |

## Reset

```bash
docker compose down -v
bash scripts/bootstrap.sh
```
