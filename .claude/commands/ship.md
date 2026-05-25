---
allowed-tools: Bash, Read, Write
description: Runs lint + tests + deploy in sequence. Stops on first failure.
---

Run the full delivery pipeline:

```bash
bash scripts/lint.sh && bash scripts/test.sh && bash scripts/deploy.sh
```

If any step fails:
1. Show the exact error.
2. Suggest the most likely fix.
3. Do not proceed to deploy.

On success, append a line to `docs/journal/session-notes.md`:
```
[YYYY-MM-DD HH:MM] Shipped — <short description of what was deployed>
```
