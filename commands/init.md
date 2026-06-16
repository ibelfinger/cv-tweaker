---
description: Scaffold a new cv-tweaker workspace into the current directory
---

You are initializing a new **cv-tweaker** workspace in the user's current working
directory. Follow these steps exactly.

1. **Guard against overwriting.** Check whether this directory is already a cv-tweaker
   workspace by testing for an existing `career/` or `applications/` directory:

   ```bash
   if [ -d career ] || [ -d applications ]; then echo "ALREADY_INITIALIZED"; fi
   ```

   If that prints `ALREADY_INITIALIZED`, STOP. Tell the user this folder already looks
   like a cv-tweaker workspace and you will not overwrite it. Do not proceed. (The folder
   does not otherwise need to be empty.)

2. **Copy the starter workspace** from the plugin into the current directory, then make
   the build script executable:

   ```bash
   cp -R "${CLAUDE_PLUGIN_ROOT}/starter/." .
   chmod +x build.sh
   ```

3. **Confirm and orient.** List the top-level entries that were created (`ls -1`), then
   tell the user the next steps:
   - Fill in `career/00-profile.md` (contact, summary variants, skills, education,
     languages) and `career/about-me.md`.
   - Drop an existing resume into `_seed/` as raw source material.
   - Add one file per role under `career/`, copied from `career/role-template.md` (or use
     the interview playbooks: "let's deepen the &lt;role&gt; role" / "let's work on my
     about-me").
   - The full workflow and house style are documented in the workspace `CLAUDE.md` that
     was just created.
   - Tailoring a CV from a job link will be handled by `/cv-tweaker:tailor-cv` (coming in
     a later release).
