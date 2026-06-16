# cv-tweaker

A Claude Code plugin that turns a job link into a tailored, ATS-optimized CV — mined
honestly from a reusable **career inventory** you build once and reuse for every
application. Nothing lands on a CV that you didn't actually do; tailoring means selecting
and reframing real experience to match a job description.

## Install

In Claude Code:

```
/plugin marketplace add ibelfinger/cv-tweaker
/plugin install cv-tweaker@cv-tweaker
```

## Quick start

cv-tweaker works inside a **workspace** that lives in your own directory — your career
data never lives inside the plugin, and plugin updates never touch it.

1. Open an empty folder (`mkdir my-cv && cd my-cv`) in Claude Code.
2. Run `/cv-tweaker:init` to scaffold a complete workspace into it.
3. Fill in `career/00-profile.md` and `career/about-me.md`, and drop an existing resume
   into `_seed/` as raw material.
4. Add a file per role under `career/` (copy `career/role-template.md`, or use the
   interview playbooks to build them up one question at a time).
5. Tailor a CV against a job link (coming soon: `/cv-tweaker:tailor-cv`).

## What's in a workspace

`init` gives you: a `career/` inventory (your source of truth), `template/` LaTeX styles,
an `applications/` folder (one folder per job), a `build.sh` that compiles a `.tex` to PDF
and checks the page count, and a workspace `CLAUDE.md` documenting the full workflow and
house style.

## Requirements

- Claude Code with plugin support.
- `pdflatex` (TeX Live / MacTeX) for compiling CVs to PDF.

## Roadmap

This release ships packaging plus the `init` command. Planned commands: `tailor-cv`
(job link -> tailored CV), `deepen-role`, `about-me`, `cover-letter`, and `build`.

## License

MIT — see `LICENSE`.
