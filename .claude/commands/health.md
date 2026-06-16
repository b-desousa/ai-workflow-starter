---
allowed-tools: Bash
description: Lightweight docs freshness check. Detects drift between the last workflow commit and HEAD using git only. No file reads, no code analysis. Run this whenever you suspect docs are behind.
---

# /health

Diagnose docs freshness using git only. No code is read. No files are written. Output a report and exit.

## Step 1 — Find last workflow tag

```bash
git describe --tags --match "workflow/*" --abbrev=0 2>/dev/null || echo "NO_WORKFLOW_TAG"
```

If `NO_WORKFLOW_TAG`: report that no workflow session has been closed yet and stop. Suggest running `/session-close` or `/documentor`.

## Step 2 — Measure drift

```bash
LAST_TAG=$(git describe --tags --match "workflow/*" --abbrev=0)

# Commits since last workflow tag
git log --oneline $LAST_TAG..HEAD

# Files changed since last workflow tag
git diff --name-only $LAST_TAG..HEAD

# Date of last workflow tag
git log -1 --format="%ar" $LAST_TAG
```

## Step 3 — Check docs freshness

```bash
# Last modified dates of the three core doc files
git log -1 --format="%as" -- docs/project.md
git log -1 --format="%as" -- docs/architecture.md
git log -1 --format="%as" -- docs/journal/session-notes.md
```

Compare each date against the date of `$LAST_TAG`. Flag as ⚠ if the doc file was last updated *before* the tag (meaning it hasn't been touched since the last workflow run, which is expected) but there are commits since the tag that touch non-doc files.

## Step 4 — Print report

```
Health check.

Last workflow tag: <tag>  (<X days/hours ago>)
Commits since:     N
Files touched:     [list, max 10, then "+ N more"]

Docs freshness:
- session-notes.md   last updated: YYYY-MM-DD  [OK | ⚠ may be stale]
- architecture.md    last updated: YYYY-MM-DD  [OK | ⚠ may be stale]
- project.md         last updated: YYYY-MM-DD  [OK | ⚠ may be stale]

Verdict: [OK — docs appear up to date | ⚠ drift detected — run /health-fix]
```

If verdict is OK and commits since = 0: print `Docs are fully up to date.` and stop.
If verdict is ⚠: print `Run /health-fix to repair.`

Do not write any file. Do not suggest specific doc changes. Diagnose only.
