#!/usr/bin/env bash
set -e

echo "[deploy] Starting deployment..."

# Option A: Coolify auto-deploy on git push (recommended)
# Just push to main — Coolify handles the rest.
git push origin main

# Option B: Manual Docker build + push
# Uncomment if using a manual flow:
# docker build -t your-app:latest .
# docker push your-registry/your-app:latest

echo "[deploy] Done. Check Coolify dashboard for deployment status."
