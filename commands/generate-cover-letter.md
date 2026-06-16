---
description: Generate a one-page cover letter for a stored job description
argument-hint: [application slug (optional; defaults to the last JD)]
---

You are generating a one-page cover letter for a stored job description. Work in the user's
current workspace directory.

## 1. Resolve the JD + check prerequisites

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

- Target application: the slug the user named (verify its folder exists and has a
  `job-description.md`; if not, list the `APPLICATIONS:` slugs and ask), else the newest
  `APPLICATIONS:` entry whose `have=[...]` includes `jd` (normally the one marked `LAST`).
  If no application has a `jd`, STOP and tell the user to run `/cv-tweaker:set-jd` first.
- HARD: at least one role under `ROLES:` and `PROFILE: filled`. If not, STOP -> run
  `/cv-tweaker:setup-from-cv` first.
- SOFT: if `ABOUTME: placeholder`, warn you cannot match the user's voice well (offer
  `/cv-tweaker:about-me` first). If this application has no `fit.md`/`notes.md`, warn the
  letter will be less targeted (offer `/cv-tweaker:assess-fit` / `/cv-tweaker:generate-cv`
  first). Proceed if the user wants.
- Read `applications/<slug>/job-description.md`, plus `fit.md` and `notes.md` if present.

## 2. Write the letter (honest; the user's voice)

Read `${CLAUDE_PLUGIN_ROOT}/references/cv-guidelines.md` (shared formatting) and
`career/about-me.md` (voice). Copy `template/cover-letter-skeleton.tex` to
`applications/<slug>/cover-letter.tex` and replace each `% <<MARKER>>` (SUBTITLE, DATE,
RECIPIENT, SALUTATION, BODY). One page. Lead on genuine fit; own the gaps named in
`fit.md`/`notes.md` head-on (owning them plainly is the point); match the user's voice from
`about-me.md`; no corporate cheerfulness. Honest reframing only - everything traces to
`career/`. LaTeX-escape `%`, `$`, `&`, `#`, `_`.

## 3. Compile

```bash
bash build.sh applications/<slug> cover-letter
```

Confirm it reports one page. Optionally also write a plain-text
`applications/<slug>/cover-letter.md` for pasting into forms/email. Report the file paths.
