---
name: feature-delivery
description: End-to-end workflow to implement a feature from spec to shipping. Use when you have a written spec and want to go from zero to deployed.
agents: [main_agent]
---

# Feature delivery skill

Follow these steps in order. Do not skip steps.

## 1. Read the spec

- Load the relevant spec from `docs/specs/features/`.
- If no spec exists, stop and ask the user to create one using the template.

## 2. Explore

- Identify all files that need to be created or modified.
- List them explicitly before writing any code.

## 3. Plan

- Write a short plan (5–10 bullets max).
- Get confirmation before proceeding.

## 4. Implement

- Make changes file by file.
- After each file, briefly explain the change.

## 5. Verify

```bash
bash scripts/lint.sh
bash scripts/test.sh
```

Fix any errors before continuing.

## 6. Document

- Update the spec status to `shipped`.
- Add a line to `docs/journal/session-notes.md`.
- If an architecture decision was made, create an ADR.

## 7. Ship

```bash
bash scripts/deploy.sh
```
