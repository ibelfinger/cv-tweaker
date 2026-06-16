---
description: Assess fit between your inventory and a stored job description
argument-hint: [application slug (optional; defaults to the last JD)]
---

You are assessing how well the user's inventory fits a stored job description. Work in the
user's current workspace directory.

## 1. Resolve the JD (prerequisite)

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

- Target application: the slug the user named (verify its folder exists and has a
  `job-description.md`; if not, list the `APPLICATIONS:` slugs and ask), else the newest
  `APPLICATIONS:` entry whose `have=[...]` includes `jd` (normally the one marked `LAST`).
- If no application has a `jd`, STOP and tell the user to run `/cv-tweaker:set-jd` first.
- Read `applications/<slug>/job-description.md`.
- SOFT: if `PROFILE: placeholder`, `ROLES:` is empty/shallow, or `ABOUTME: placeholder`, warn
  that the assessment will be coarse and offer to run `/cv-tweaker:setup-from-cv`,
  `/cv-tweaker:deepen-role`, or `/cv-tweaker:about-me` first. Proceed if the user wants.

## 2. Assess (honest)

Read `career/00-profile.md`, the role files, and `career/about-me.md`. Compare against the JD:
- hard-requirement coverage (met / partial / missing, each traced to the inventory),
- strengths to lead on,
- gaps and concrete ways to address them,
- ATS keyword overlap (present vs missing),
- seniority / title match.

Ground every claim in the inventory (honest; see
`${CLAUDE_PLUGIN_ROOT}/references/cv-guidelines.md`). Do not invent qualifications.

## 3. Write and dump

Write the full assessment to `applications/<slug>/fit.md`, AND output the entire report in the
conversation (the complete report, not a summary).
