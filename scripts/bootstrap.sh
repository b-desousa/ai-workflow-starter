#!/usr/bin/env bash
set -e

echo "[bootstrap] Setting up project..."

# Copy env example if .env doesn't exist
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
    echo "[bootstrap] .env created from .env.example — fill in your values."
  else
    echo "[bootstrap] No .env.example found — create one if needed."
  fi
fi

# Install dependencies (adapt to your stack)
if [ -f package.json ]; then
  echo "[bootstrap] Installing Node dependencies..."
  npm install
elif [ -f requirements.txt ]; then
  echo "[bootstrap] Installing Python dependencies..."
  pip install -r requirements.txt
else
  echo "[bootstrap] No package.json or requirements.txt found — adapt this script to your stack."
fi

echo "[bootstrap] Done."
