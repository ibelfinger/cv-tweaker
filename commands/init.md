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
   user to run (note the absolute path so a fresh BasicTeX works before PATH refreshes):

   ```bash
   sudo /Library/TeX/texbin/tlmgr install <packages from INSTALL:>
   ```

   If that errors with a version/"local revision" mismatch, have them run
   `sudo /Library/TeX/texbin/tlmgr update --self` first, then retry the install.

5. Re-run the detector after any install and re-evaluate. Repeat Phases 1.3-1.5 until the
   detector exits `0` (this cascades naturally: installing the engine leaves packages
   missing, which the next pass catches), or the user chooses to stop.

## Phase 2 - Verify (test compile)

Only do this once the detector exits `0`. It compiles the real template through the real
build script in a throwaway directory, so `applications/` is untouched:

```bash
TMP="$(mktemp -d)"
cp template/skeleton.tex "$TMP/cv.tex"
./build.sh "$TMP"
ls -1 "$TMP"/cv.pdf 2>/dev/null && echo "VERIFY_OK" || echo "VERIFY_FAILED"
rm -rf "$TMP"
```

- If you see `built: ... (N pages)` and `VERIFY_OK`: tell the user the toolchain is
  verified.
- If it failed: show the relevant `! ...`/error lines from the `build.sh` output and tell
  the user verification failed. Do NOT claim success. Still keep the scaffolded workspace.

If the toolchain was never made ready in Phase 1, skip Phase 2, tell the user the
workspace is scaffolded but LaTeX still needs finishing, repeat the exact remaining
command, and note that re-running `/cv-tweaker:init` resumes at the doctor step.

## Orientation (end)

On a fresh scaffold, list the top-level entries created (`ls -1`). Then give next steps:
- Fill `career/00-profile.md` (contact, summary variants, skills, education, languages)
  and `career/about-me.md`.
- Drop an existing resume into `_seed/` as raw material.
- Add one file per role under `career/`, copied from `career/role-template.md` (or use the
  interview playbooks: "let's deepen the &lt;role&gt; role" / "let's work on my about-me").
- The full workflow and house style live in the workspace `CLAUDE.md`.
- Job-link tailoring will arrive as `/cv-tweaker:tailor-cv` in a later release.
