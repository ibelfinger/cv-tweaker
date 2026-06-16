# Career inventory

The over-stuffed source of truth. Deliberately richer than any single CV needs -
tailored CVs are *mined* from here. Nothing appears on a CV that is not in these
files (honest reframing only; no fabrication).

## Files
- `00-profile.md` — contact, summary variants, skills, education, languages.
- `about-me.md` — identity 1-pager (engineer/leader/beliefs/outside life).
- `role-template.md` — blank per-role skeleton; copy it per position.
- `<role>.md` — one file per role (lowercase, hyphenated, e.g. `acme.md`),
  created from `role-template.md`.

### Interview playbooks
- `role-interview.md` — how to deepen a role file (adaptive, per-role).
- `about-me-interview.md` — how to build `about-me.md` (hybrid, identity).

## Per-role file format
Each role file uses this structure:

```markdown
# <Company> — <Title>
Location · Dates · Reporting line · Team size / scope

## Narrative arc
Why you joined, the state on arrival, how it evolved, why you left.

## Context
What the company is, its scale, the business, the mandate.

## What I owned
Teams, domains, budgets, surfaces.

## Initiatives
### <Initiative name>
- Situation / problem
- What I did (decisions, architecture, leadership moves)
- Tech & tools used
- Outcome with hard metrics

## Metrics bank
Every quantified result, raw and reusable.

## Tech & architecture
Concrete languages, frameworks, datastores, infra, patterns.

## Leadership & people
Hiring, mentoring, stakeholders, who you reported to.

## Decisions & tradeoffs
Judgment calls worth remembering.

## Challenges & lessons
What went wrong; what you'd do differently.

## Tech & keywords
Flat tag list for ATS keyword matching.

## Open threads
Living list of what is still thin - the resume point for the next interview.
```

## Maintenance
Add detail freely - granularity is the point. The fastest way to enrich a file is
the interview playbooks above ("deepen the <role> role" / "work on my about-me");
they ask one question at a time and only record what you say.
