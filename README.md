# cv-tweaker

A Claude Code plugin that turns a job description into a tailored, ATS-optimized CV (and
matching cover letter), mined from a reusable **career inventory** you build once and reuse
for every application.

The premise: keep one over-stuffed, honest record of everything you've done, then *select and
reframe* from it per job. Nothing lands on a CV that you didn't actually do - "tailoring"
means mirroring a job's wording where it truthfully describes your work, not inventing.

Your data lives in **your** workspace, never inside the plugin. Plugin updates never touch it.

---

## 1. Install

In Claude Code:

```
/plugin marketplace add ibelfinger/cv-tweaker
/plugin install cv-tweaker@cv-tweaker
```

You also need `pdflatex` to compile PDFs (TeX Live / MacTeX / BasicTeX). If it's missing,
`init` detects that and walks you through installing it.

## 2. Set up a workspace

Open an empty folder in Claude Code and initialize it:

```
mkdir my-cv && cd my-cv      # any empty folder
/cv-tweaker:init
```

`init` scaffolds the workspace (see [the folder structure](#6-deeper-dive-the-workspace)),
checks your LaTeX toolchain - installing any missing packages with your confirmation, never
silently - and compiles a test document to prove the chain works end to end.

## 3. Fill in your history

The career inventory is the source of truth everything is mined from. Two ways in:

- **Start from an existing CV.** Drop a PDF/Markdown/text resume into `_seed/`, then:
  ```
  /cv-tweaker:setup-from-cv
  ```
  It reads the CV, detects your discipline (engineer, or a neutral profile for PM / TPM /
  designer / data / ...), and creates a skeleton role file per job plus your profile - filled
  only with what the CV actually says.

- **Deepen it through interviews.** The CV gives shallow data; the real value comes from
  going deeper, one question at a time:
  ```
  /cv-tweaker:deepen-role        # enrich a role (picks the thinnest, or name one)
  /cv-tweaker:about-me           # build your identity 1-pager (style, beliefs, what's next)
  ```
  These only record your own words - no invented metrics or personality. Re-run them any
  time; each file remembers where it left off.

Richer inventory in, better CVs out.

## 4. Tailor to a job

An "application" is a folder that grows from a job description into a CV and a letter:

```
/cv-tweaker:set-jd <url or paste the JD>   # stores it; becomes the "last JD"
/cv-tweaker:assess-fit                      # honest gap/fit analysis: strengths, gaps, keywords
/cv-tweaker:generate-cv                     # tailored two-page CV (overshoot-then-trim to fit)
/cv-tweaker:generate-cover-letter           # one-page letter in your voice, owning the gaps
```

`set-jd` takes a job URL (opened via the Playwright MCP) or pasted text. `assess-fit`,
`generate-cv`, and `generate-cover-letter` default to that last JD - or pass an application
slug to target a different one. Each flags up front if the inventory backing it is thin, and
lets you proceed anyway or go deepen first.

**This step is repeatable, and the earlier ones are not.** You set up the workspace and build
the inventory once (steps 2-3); every new job is just these four commands against the same
`career/` - no re-running `init`, no re-entering your history. Each application is its own
folder, so previous CVs and letters stay put.

## 5. Extra goodies

```
/cv-tweaker:review-career
```

A reflective, lightly psychological read of your career - trajectory, the kinds of roles you
gravitate to, recurring strengths, honest open questions - grounded only in what's recorded.
A nice mirror once your inventory has some depth.

## 6. Deeper dive: the workspace

`init` scaffolds a plain folder of Markdown and LaTeX you fully own. Nothing is hidden.

```
my-cv/
├── career/                      # the inventory - your source of truth
│   ├── 00-profile.md            # contact, summary variants, skills, education, languages
│   ├── about-me.md              # identity 1-pager (feeds summaries + cover-letter voice)
│   ├── <role>.md                # one file per job, deepened over time
│   ├── role-template.md         # the section structure a role file uses
│   └── README.md
├── applications/                # one folder per job application
│   └── <YYYY-MM-DD-company-role>/
│       ├── job-description.md    # set-jd
│       ├── fit.md               # assess-fit
│       ├── cv.tex / cv.pdf      # generate-cv
│       ├── cover-letter.*       # generate-cover-letter
│       └── notes.md             # what was emphasized vs cut, gaps for the letter
├── template/                    # the fixed LaTeX house style
│   ├── skeleton.tex             # CV (single-column, ATS-safe)
│   └── cover-letter-skeleton.tex
├── _seed/                       # drop your existing CV here (raw material only)
├── build.sh                     # compiles <dir>/<name>.tex -> PDF, prints the page count
└── CLAUDE.md                    # workspace context: layout, principles, command index
```

How it hangs together: the **inventory** (`career/`) is mined per job; `generate-cv` fills the
**template** markers into `applications/<slug>/cv.tex` and drives `build.sh` until the CV is a
genuinely full two pages (overshoot to three, then trim the least-valuable - never padding).
The house style (ATS-safe single column, no em-dashes, honest reframing, Earlier-Experience
collapsing of older roles) is applied by the generate commands. Because the workspace is just
files, you can edit anything by hand and version-control it yourself, separately from this
plugin.

### Using your own CV template
The look of the CV is plain LaTeX you own: `template/skeleton.tex` (and
`template/cover-letter-skeleton.tex`). Restyle it however you like - colors, fonts, spacing,
layout - but keep the `% <<MARKER>>` insertion comments (`<<SUMMARY>>`, `<<SKILLS>>`,
`<<EXPERIENCE>>`, `<<TECHSKILLS>>`, `<<COMMUNITY>>`), which `generate-cv` fills on each run,
and the constant header / education blocks, which `setup-from-cv` fills once and every CV
reuses. Your changes are picked up on the next `generate-cv` run - no plugin update needed,
since the template lives in your workspace.

---

## License

MIT - see `LICENSE`.
