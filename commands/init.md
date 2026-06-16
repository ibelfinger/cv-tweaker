---
description: Scaffold a cv-tweaker workspace here, ensure the LaTeX toolchain, and verify it
---

You are setting up a **cv-tweaker** workspace in the user's current working directory.
Work through three phases in order. Run plain detection, scaffolding, and the verify
compile yourself; for anything that needs `sudo` or a `brew` cask install, DO NOT run it
via your shell (it will hang on a password prompt) — print the exact command and ask the
user to run it, then continue once they confirm.

## Phase 0 - Scaffold

1. Check whether this is already a workspace:

   ```bash
   if [ -d career ] || [ -d applications ]; then echo "ALREADY"; fi
   ```

   - If it prints `ALREADY`: tell the user the folder is already a cv-tweaker workspace,
     do NOT copy anything, and continue to Phase 1 (init also repairs the toolchain).
   - Otherwise, scaffold from the plugin and make the build script executable:

     ```bash
     cp -R "${CLAUDE_PLUGIN_ROOT}/starter/." .
     chmod +x build.sh
     ```

## Phase 1 - LaTeX doctor

1. Run the detector and read its report and exit code:

   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/check-latex.sh"; echo "EXIT=$?"
   ```

   The last line is `INSTALL: <space-separated tlmgr packages>` (empty when nothing is
   missing). `ENGINE:` is `ok` or `missing`.

2. If `EXIT=0`: the toolchain is ready - tell the user and go to Phase 2.

3. If the engine is missing:
   - macOS with Homebrew (`command -v brew` succeeds): ask the user to run
     `brew install --cask basictex` (it will prompt for their password). Mention they may
     need to open a new terminal afterward so `/Library/TeX/texbin` is on PATH.
   - macOS without Homebrew: point them to https://brew.sh then the above, or MacTeX.
   - Linux: detect the package manager and give the closest one-liner for the user to run,
     e.g. apt:
     `sudo apt-get install texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended`
     (dnf: `sudo dnf install texlive-scheme-medium`; pacman: `sudo pacman -S texlive-most`).
   - Other/unknown OS: ask them to install TeX Live or MiKTeX.
   - Do not auto-install. After they confirm, re-run the detector (step 1).

4. If the engine is present but packages are missing: take the `INSTALL:` list and ask the
   user to run this themselves - do NOT run it yourself (it needs a sudo password you
   cannot supply). The absolute path makes a fresh BasicTeX work before PATH refreshes:

   ```text
   sudo /Library/TeX/texbin/tlmgr install <packages from INSTALL:>
   ```

   That absolute path is macOS BasicTeX. On Linux, have the user install the missing
   packages via their distro's `texlive-*` packages (or a plain `tlmgr install` if they
   manage TeX Live themselves).

   If that errors with a version/"local revision" mismatch, have them run
   `sudo /Library/TeX/texbin/tlmgr update --self` first, then retry the install.

5. Re-run the detector after any install and re-evaluate. Repeat Phases 1.3-1.5 until the
   detector exits `0` (this cascades naturally: installing the engine leaves packages
   missing, which the next pass catches), or the user chooses to stop.

## Phase 2 - Verify (test compile)

Only do this once the detector exits `0`. It compiles the real template through the real
build script in a throwaway directory, so `applications/` is untouched. Run it as a
SINGLE shell block (it relies on `$TMP` persisting across the lines):

```bash
TMP="$(mktemp -d)"
cp template/skeleton.tex "$TMP/cv.tex"
if bash build.sh "$TMP"; then
  echo "VERIFY_OK"
else
  echo "VERIFY_FAILED"
  grep -A2 '^!' "$TMP/cv.log" 2>/dev/null   # build.sh swallows pdflatex output; errors live in cv.log
fi
rm -rf "$TMP"
```

- `VERIFY_OK` (with a `built: ... (N pages)` line above it): tell the user the toolchain is
  verified.
- `VERIFY_FAILED`: `build.sh` captures pdflatex's output, so the LaTeX errors survive only
  in `$TMP/cv.log` - the `grep` above prints those `! ...` lines before cleanup. Show them
  to the user, say verification failed, and do NOT claim success. Keep the scaffolded
  workspace.

If the toolchain was never made ready in Phase 1, skip Phase 2, tell the user the
workspace is scaffolded but LaTeX still needs finishing, repeat the exact remaining
command, and note that re-running `/cv-tweaker:init` resumes at the doctor step.

## Orientation (end)

On a fresh scaffold, list the top-level entries created (`ls -1`). Then give next steps:
- If you have an existing CV, drop it into `_seed/` and run `/cv-tweaker:setup-from-cv` to
  bootstrap your inventory from it. Otherwise fill `career/00-profile.md` and
  `career/about-me.md` by hand, adding a file per role from `career/role-template.md`.
- The full workflow and house style live in the workspace `CLAUDE.md`.
- Deepening and job tailoring arrive as later commands: `deepen-role`, `about-me`,
  `set-jd`, `assess-fit`, `generate-cv`, `generate-cover-letter`, `review-career`.
