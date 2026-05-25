---
name: project-bootstrap
description: Initializes a new project from this starter — fills in vision, scope, first ADR, and first feature spec. Use at the very start of a project.
agents: [main_agent]
---

# Project bootstrap skill

You are setting up a new project from scratch.

## Step 1 — Vision

Ask the user:
1. What is the project? (1 sentence)
2. Who is it for? (user or system)
3. What problem does it solve?
4. What does success look like in 4 weeks?

Fill `docs/project/vision.md` with the answers.

## Step 2 — Scope

Ask:
1. What is explicitly in scope for v1?
2. What is explicitly out of scope?
3. Any known constraints? (tech stack, deadline, budget)

Fill `docs/project/scope.md`.

## Step 3 — Stack decision

Based on the vision and scope, suggest a stack.
Create `docs/decisions/001-choix-stack.md` using the ADR template.

## Step 4 — First feature spec

Ask: what is the first feature to build?
Create `docs/specs/features/<feature-slug>.md` using the spec template.

## Step 5 — Confirm

Show a summary of what was created and ask for confirmation before writing files.
