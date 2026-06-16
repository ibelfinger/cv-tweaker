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
3. If you have an existing CV, drop it into `_seed/` and run `/cv-tweaker:setup-from-cv` to
   bootstrap your inventory from it. Otherwise fill `career/00-profile.md`,
   `career/about-me.md`, and a file per role (from `career/role-template.md`) by hand.
4. Enrich the inventory and tailor a CV / cover letter to a specific job using the commands
   in the Roadmap as they land.

## What's in a workspace

`init` gives you: a `career/` inventory (your source of truth), `template/` LaTeX styles,
an `applications/` folder (one folder per job), a `build.sh` that compiles a `.tex` to PDF
and checks the page count, and a workspace `CLAUDE.md` documenting the full workflow and
house style.

## Requirements

- Claude Code with plugin support.
- `pdflatex` (TeX Live / MacTeX) for compiling CVs to PDF.

## Roadmap

Shipped: `init` (scaffold a workspace) and `setup-from-cv` (bootstrap the inventory from an
existing CV). Planned, in stages: `deepen-role` and `about-me` (interview-driven inventory
deepening); `set-jd`, `assess-fit`, `generate-cv`, `generate-cover-letter` (job-tailored CV
and cover letter); and `review-career` (a reflective read of your trajectory).

## License

MIT — see `LICENSE`.
