#!/usr/bin/env bash
# workspace-status.sh - report cv-tweaker workspace state as facts.
# Detection ONLY: no writes, no judgment. Exit 0 always (a report, not a gate).
# Usage: workspace-status.sh [workspace-root]   (default: current directory)
set -u

ROOT="${1:-.}"
cd "$ROOT" 2>/dev/null || { echo "ERROR: cannot cd to $ROOT"; exit 0; }

CAREER="career"
APPS="applications"
# career/ files that are NOT role files:
NONROLE="00-profile.md about-me.md role-template.md README.md role-interview.md about-me-interview.md"
is_nonrole() { case " $NONROLE " in *" $1 "*) return 0;; *) return 1;; esac; }

# PROFILE: placeholder while the Name field still holds the template token.
if [ -f "$CAREER/00-profile.md" ] && ! grep -q '\[Full name\]' "$CAREER/00-profile.md"; then
  echo "PROFILE: filled"
else
  echo "PROFILE: placeholder"
fi

# DISCIPLINE: recorded in 00-profile.md by setup-from-cv; bracket placeholder => unknown.
disc="unknown"
if [ -f "$CAREER/00-profile.md" ]; then
  d="$(grep -iE 'discipline' "$CAREER/00-profile.md" | head -1 | sed -E 's/.*[Dd]iscipline:?[*]*[[:space:]]*//; s/[*]*[[:space:]]*$//')"
  case "$d" in ""|\[*) disc="unknown";; *) disc="$d";; esac
fi
echo "DISCIPLINE: $disc"

# ABOUTME: placeholder while unfilled bracket-prompt lines remain.
if [ -f "$CAREER/about-me.md" ] && ! grep -qE '^\[' "$CAREER/about-me.md"; then
  echo "ABOUTME: filled"
else
  echo "ABOUTME: placeholder"
fi

# ROLES: one line per role file (name, line count, Open-threads item count).
echo "ROLES:"
if [ -d "$CAREER" ]; then
  for f in "$CAREER"/*.md; do
    [ -e "$f" ] || continue
    base="$(basename "$f")"
    is_nonrole "$base" && continue
    lines="$(wc -l < "$f" | tr -d ' ')"
    threads="$(awk '/^## Open threads/{f=1;next} /^## /{f=0} f&&/^[[:space:]]*-/{c++} END{print c+0}' "$f")"
    echo "  ${base%.md} lines=$lines open_threads=$threads"
  done
fi

# APPLICATIONS: one line per folder; newest by mtime marked LAST.
echo "APPLICATIONS:"
if [ -d "$APPS" ]; then
  last=""
  newest="$(ls -1dt "$APPS"/*/ 2>/dev/null | head -1)"
  [ -n "$newest" ] && last="$(basename "$newest")"
  for d in "$APPS"/*/; do
    [ -d "$d" ] || continue
    slug="$(basename "$d")"
    have=""
    [ -f "$d/job-description.md" ] && have="$have jd"
    [ -f "$d/fit.md" ] && have="$have fit"
    [ -f "$d/cv.pdf" ] && have="$have cv"
    mark=""; [ "$slug" = "$last" ] && mark=" LAST"
    echo "  $slug have=[${have# }]$mark"
  done
fi

exit 0
