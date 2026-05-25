---
name: deploy-coolify
description: Prepares and runs a Coolify deployment — checks Docker config, env vars, build command, and health check. Use before any production push.
agents: [main_agent]
---

# Deploy via Coolify skill

## Pre-flight checklist

1. Is `infra/docker/Dockerfile` present and valid?
2. Is `.env.example` up to date with all required variables?
3. Are there any hardcoded secrets in source? (run a quick grep)
4. Is the build command correct in `scripts/deploy.sh`?

```bash
grep -r "API_KEY\|SECRET\|PASSWORD\|TOKEN" src/ --include="*.ts" --include="*.js" --include="*.py"
```

## Deploy steps

```bash
bash scripts/lint.sh     # Must pass
bash scripts/test.sh     # Must pass
bash scripts/deploy.sh   # Build + push
```

## Post-deploy checks

- Confirm health endpoint responds.
- Check Coolify logs for startup errors.
- Add a line to `docs/journal/session-notes.md` with: date, version, what changed, any issues.

## Rollback

In Coolify UI: Deployments → select previous → Redeploy.
Document the incident in `docs/operations/runbook-prod.md`.
