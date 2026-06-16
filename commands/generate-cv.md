---
description: Generate a tailored two-page CV for a stored job description
argument-hint: [application slug (optional; defaults to the last JD)]
---

You are generating a tailored, ATS-optimized CV for a stored job description. Work in the
user's current workspace directory.

## 1. Resolve the JD + check prerequisites

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

- Target application: the slug the user named (verify it exists; if not, list the
  `APPLICATIONS:` slugs and ask), else the one marked `LAST`. If none has a `jd`, STOP and
  tell the user to run `/cv-tweaker:set-jd` first.
- HARD: there must be at least one role under `ROLES:` and `PROFILE: filled`. If not, STOP and
  tell the user to run `/cv-tweaker:setup-from-cv` first.
- SOFT: if roles are shallow (high `open_threads` / few `lines`) or `ABOUTME: placeholder`,
  warn that tailoring will be weaker and offer `/cv-tweaker:deepen-role` /
  `/cv-tweaker:about-me` first. Proceed if the user wants.
- Read `applications/<slug>/job-description.md`.

## 2. Tailor (honest reframing)

Read and follow `${CLAUDE_PLUGIN_ROOT}/references/cv-guidelines.md`. Mine `career/` (profile +
role files): select the relevant roles/initiatives, reframe honestly to mirror the JD's
wording, and choose the summary variant + skills ordering. Copy `template/skeleton.tex` to
`applications/<slug>/cv.tex` and replace each `% <<MARKER>>` (SUMMARY, SKILLS, EXPERIENCE,
TECHSKILLS, COMMUNITY). LaTeX-escape `%`, `$`, `&`, `#`, `_`.

## 3. Compile and fit to two pages

```bash
bash build.sh applications/<slug>
```

Read the page count it prints, then apply the overshoot-then-trim loop from
`cv-guidelines.md`: overshoot to a real 3 pages with genuine bullets, then trim the
least-valuable until it drops to a full 2 pages; never pad with filler. When there are many
roles, ASK the user where to draw the "Earlier Experience" line (no fixed year).

## 4. Record

Write `applications/<slug>/notes.md`: keywords targeted, what was emphasized vs cut, and gaps
worth addressing in a cover letter. Report the final page count and the file paths.
