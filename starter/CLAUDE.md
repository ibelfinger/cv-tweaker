# cv-tweaker — Career inventory + tailored-CV system

This repo turns a job link into a tailored, ATS-optimized CV. Two assets carry
the value: the **career inventory** (`career/`, the over-stuffed source of
truth) and **tailoring judgment** (selecting/reframing inventory content to fit
a specific JD). The LaTeX styling is fixed in `template/skeleton.tex`.

## Layout
- `career/` — inventory (one file per role + `00-profile.md`). See `career/README.md`.
- `template/skeleton.tex` — the CV style; insertion markers for variable sections.
- `template/cover-letter-skeleton.tex` — the cover-letter style (same visual
  identity, wider margins); insertion markers. Optional, per application.
- `applications/<YYYY-MM-DD-company-role>/` — one folder per application.
- `build.sh` — compile `<dir>/<name>.tex` → `<name>.pdf` (name defaults to `cv`;
  pass `cover-letter` for the letter).
- `_seed/` — original résumé, raw material only.

## Workflow — when the user sends a job link
1. **Slug + folder.** Create `applications/<YYYY-MM-DD>-<company>-<role>/`
   (lowercase, hyphenated).
2. **Capture the JD.** Use the Playwright MCP to open the URL in the user's
   authenticated browser session and extract the job description; save it to
   `<dir>/job-description.md`. If the page resists, ask the user to paste it.
3. **Analyze.** Extract hard requirements, ATS keywords, terminology, and
   seniority signals from the JD.
4. **Mine the inventory.** Select relevant roles/initiatives from `career/`,
   reframe honestly to mirror the JD's wording, choose the summary variant and
   skills ordering. Fit **two pages max**. Apply the CV conventions below.
5. **Generate.** Copy `template/skeleton.tex` to `<dir>/cv.tex` and replace each
   `% <<MARKER>>`. LaTeX-escape `%`, `$`, `&`, `#`, `_`.
6. **Compile.** Run `./build.sh applications/<dir>` → `cv.pdf`.
7. **Record.** Write `<dir>/notes.md`: keywords targeted, what was emphasized
   vs cut, and gaps worth addressing in a cover letter.
8. **Cover letter (optional, on request).** See "Cover letters" below.

## Rules
- **Honest reframing only.** Everything on a CV must trace to `career/`. Never
  fabricate roles, metrics, skills, or scope. Mirror JD terminology only where
  it truthfully describes what the user did.
- **Two pages maximum.**
- **No invention of contact/education** — those are fixed in `00-profile.md`.

## CV-output conventions
- **Earlier Experience:** older roles (e.g. pre-~2018) collapse into a single
  "Earlier Experience" block — one line each (company · title · dates · one
  line). Not merged into one role; compressed. Recent roles keep full bullets.
- **Short contracts:** if ever shown, always labelled "(Contract)" and never a
  prominent full-bullet entry without the label. Per JD, FEATURE or OMIT.
- **Honest omissions:** a short or unsuccessful stint (e.g. a role left during
  probation) may be omitted entirely - that is honest. Never relabel or
  misrepresent it (e.g. dressing a permanent role up as a contract) to make it fit.

## CV formatting & length (house style)
The skeleton bakes these in; keep them in every generated `cv.tex`:
- **Single-column, ATS-safe** — Technical Skills as labelled one-line-per-category
  (no two-column / minipage; ATS parsers scramble columns).
- **No em-dashes** anywhere (no "---", no literal em-dash); use "-" or restructure.
- **"Approximately" = `$\sim$`**, never `\textasciitilde` (renders a raised glyph).
- **Section title rule** sits tight under the title (`\vspace{-6pt}` in
  `\titleformat`); tune that value, not the rule-to-text gap.

### Fitting to two pages (repeatable: overshoot-then-trim)
`build.sh` prints the page count after each compile and warns if > 2. Fit in a few
iterations:
1. **Overshoot for real.** The layout is dense and holds far more than it looks
   (~20 bullets only half-fills page 2; a full 2 pages is ~28-32 bullets plus a
   Community/credential line). Add genuine bullets — recent roles 6-7+, pulling
   architecture/metrics/decisions/leadership from `career/*.md`, plus the Community
   credential line — until `build.sh` actually reports **3 pages** (the warning fires). Do
   not stop at "barely 2".
2. **Trim the least-valuable bullets** — oldest roles first, then weakest/redundant —
   and recompile.
3. **Stop the instant it drops to 2 pages.** Coming down from 3, that 2-page version
   has a genuinely full page 2 — the fullest fit. If you exhaust genuinely strong
   content before reaching 3 pages, stop there; never pad with filler.
Keep pre-2018 as an "Earlier Experience" one-liner block.

## Cover letters (optional, when the user asks)
Copy `template/cover-letter-skeleton.tex` to `<dir>/cover-letter.tex`, replace the
`% <<MARKER>>`s, and compile with `./build.sh <dir> cover-letter`. Same discipline as
the CV: honest reframing only (everything traces to `career/`), no em-dashes, `$\sim$`
for "approximately", LaTeX-escape `%`, `$`, `&`, `#`, `_`. **One page.** Lead on
genuine fit and address the gaps named in `notes.md` head-on - owning them plainly is
the point, not hiding them. Match the user's voice (see `career/about-me.md`); no
corporate cheerfulness. Optionally also keep a `cover-letter.md` plain-text version
for pasting into forms/email.

## Build
`pdflatex` (`/Library/TeX/texbin/pdflatex`) is required; `build.sh <dir> [name]` runs
it twice, removes `.aux/.log/.out`, and prints the page count. `name` defaults to `cv`
(2-page target, warns if > 2); pass `cover-letter` for the 1-page letter.

## Deepening the inventory (interviews)
Two documented interview processes enrich the inventory over time. Each reads its
target file, asks one question at a time, records only what the user says, and
updates the file's `## Open threads` list so it can be resumed.

- **Per-role deepening** — playbook `career/role-interview.md`. Trigger: "let's
  deepen the <role> role". Target: `career/<role>.md` (input and output).
- **About-me questionnaire** — playbook `career/about-me-interview.md`. Trigger:
  "let's work on my about-me". Target: `career/about-me.md` (input and output);
  feeds the summary variants in `00-profile.md`.

Honesty rule: record only the user's own words — never infer or embellish. Richer
inventory → better CVs.
