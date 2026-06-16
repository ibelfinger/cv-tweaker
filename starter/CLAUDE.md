# cv-tweaker — Career inventory + tailored-CV system

This repo turns a job link into a tailored, ATS-optimized CV. Two assets carry
the value: the **career inventory** (`career/`, the over-stuffed source of
truth) and **tailoring judgment** (selecting/reframing inventory content to fit
a specific JD). The LaTeX styling is fixed in `template/skeleton.tex`.

## Commands (cv-tweaker plugin)
Slash commands drive the workflow. Available now: `/cv-tweaker:init` (set up this
workspace), `/cv-tweaker:setup-from-cv` (bootstrap the inventory from an existing CV),
`/cv-tweaker:deepen-role` (deepen one role), `/cv-tweaker:about-me` (identity 1-pager),
`/cv-tweaker:set-jd`, `/cv-tweaker:assess-fit`, `/cv-tweaker:generate-cv`,
`/cv-tweaker:generate-cover-letter`, and `/cv-tweaker:review-career`. Each command
flags when a prerequisite is thin and
lets you proceed with less precise data; some (like setup-from-cv) are unavoidable.

## Layout
- `career/` — inventory (one file per role + `00-profile.md`). See `career/README.md`.
- `template/skeleton.tex` — the CV style; insertion markers for variable sections.
- `template/cover-letter-skeleton.tex` — the cover-letter style (same visual
  identity, wider margins); insertion markers. Optional, per application.
- `applications/<YYYY-MM-DD-company-role>/` — one folder per application.
- `build.sh` — compile `<dir>/<name>.tex` → `<name>.pdf` (name defaults to `cv`;
  pass `cover-letter` for the letter).
- `_seed/` — original résumé, raw material only.

## Tailoring an application
Drive the job-to-CV flow with commands, in order:
- `/cv-tweaker:set-jd` — store a job description (URL or pasted text) as a new application.
- `/cv-tweaker:assess-fit` — honest gap/fit analysis against the last (or a named) JD.
- `/cv-tweaker:generate-cv` — tailored two-page CV for that JD.
- `/cv-tweaker:generate-cover-letter` — one-page cover letter for that JD.

Each application lives under `applications/<YYYY-MM-DD-company-role>/`, growing JD → fit → CV
→ letter. `build.sh <dir> [name]` compiles a `.tex` to PDF and prints the page count (name
defaults to `cv`; pass `cover-letter` for the letter).

## Principles (apply to every CV and letter)
- **Honest reframing only.** Everything on a CV/letter must trace to `career/`. Never
  fabricate roles, metrics, skills, or scope. Mirror JD terminology only where it truthfully
  describes what you did.
- **Two pages for the CV, one for the letter.**
- **No invention of contact/education** — those are fixed in `00-profile.md`.
- **ATS-safe; no em-dashes; `$\sim$` for "approximately".** The generate commands apply the
  full house style (overshoot-then-trim two-page fit, Earlier-Experience collapsing of older
  roles, contract labelling, honest omissions).

## Deepening the inventory (interviews)
Enrich the inventory over time with two interview commands. Each asks one question at a
time, records only what you say, and updates the target file's `## Open threads` so it can
be resumed.

- `/cv-tweaker:deepen-role` — deepen one role file (`career/<role>.md`).
- `/cv-tweaker:about-me` — build the identity 1-pager (`career/about-me.md`), which feeds
  the summary variants in `00-profile.md`.

Honesty rule: record only the user's own words — never infer or embellish. Richer
inventory → better CVs.
