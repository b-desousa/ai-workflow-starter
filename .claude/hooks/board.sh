#!/bin/sh
# Session-start board: non-done specs and proposed ADRs. Silent when there is nothing to show.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
out=""
for f in docs/specs/*.md; do
  [ -f "$f" ] || continue
  s=$(sed -n 's/^status: *//p' "$f" | head -1)
  [ "$s" = done ] && continue
  out="$out
  [$s] $(sed -n 's/^# *//p' "$f" | head -1)"
done
for f in docs/adr/*.md; do
  [ -f "$f" ] || continue
  grep -qi '^Status: *proposed' "$f" || continue
  out="$out
  [proposed] $(sed -n 's/^# *//p' "$f" | head -1)"
done
[ -n "$out" ] && printf 'Spec/ADR board (not done):%s\n' "$out"
exit 0
