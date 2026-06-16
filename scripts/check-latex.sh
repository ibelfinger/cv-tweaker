#!/usr/bin/env bash
# check-latex.sh - report whether the cv-tweaker LaTeX toolchain is present.
# Detection ONLY: no installs, no sudo, no side effects. Safe to run with no TeX.
# Output: one line per package (OK/MISS), an ENGINE line, and a final machine-readable
#   "INSTALL: <tlmgr packages>" line. Exit 0 iff engine present AND nothing missing.
set -u

TEXBIN="/Library/TeX/texbin"

# Resolve a tool: prefer PATH, then the macOS TeX symlink dir.
resolve() {
  if command -v "$1" >/dev/null 2>&1; then command -v "$1"; return 0; fi
  if [ -x "$TEXBIN/$1" ]; then echo "$TEXBIN/$1"; return 0; fi
  return 1
}

# Required .sty -> tlmgr package. fontenc is base (engine); not tlmgr-installable.
PKGS="geometry:geometry enumitem:enumitem titlesec:titlesec hyperref:hyperref xcolor:xcolor parskip:parskip helvet:psnfss"

PDFLATEX="$(resolve pdflatex || true)"
KPSEWHICH="$(resolve kpsewhich || true)"

rc=0
install_list=""

if [ -n "$PDFLATEX" ]; then
  echo "ENGINE: ok ($PDFLATEX)"
else
  echo "ENGINE: missing"
  rc=1
fi

# If kpsewhich is somehow absent (no TeX at all), every package reports MISS - that is
# over-reporting in the safe direction; the ENGINE line already shows the real cause.
for entry in $PKGS; do
  sty="${entry%%:*}"
  tlpkg="${entry##*:}"
  if [ -n "$KPSEWHICH" ] && "$KPSEWHICH" "$sty.sty" >/dev/null 2>&1; then
    echo "OK   $sty.sty"
  else
    echo "MISS $sty.sty (tlmgr: $tlpkg)"
    install_list="$install_list $tlpkg"
    rc=1
  fi
done

# Trim leading space; emit machine-readable install list (may be empty).
install_list="${install_list# }"
echo "INSTALL: $install_list"

exit $rc
