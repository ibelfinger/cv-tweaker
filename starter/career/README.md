# Career inventory

The over-stuffed source of truth. Deliberately richer than any single CV needs -
tailored CVs are *mined* from here. Nothing appears on a CV that is not in these
files (honest reframing only; no fabrication).

## Files
- `00-profile.md` - contact, summary variants, skills, education, languages.
- `about-me.md` - identity 1-pager (who you are in your field, beliefs, working style).
- `role-template.md` - blank per-role skeleton; copy it per position. It defines the section
  structure every role file uses.
- `<role>.md` - one file per role (lowercase, hyphenated, e.g. `acme.md`), created from
  `role-template.md`.

## Building & deepening the inventory
- `/cv-tweaker:setup-from-cv` - bootstrap the whole inventory from an existing CV.
- `/cv-tweaker:deepen-role` - interview-style deepening of one role file.
- `/cv-tweaker:about-me` - interview-style build of `about-me.md`.

Each interview asks one question at a time and records only what you say, updating the
target file's `## Open threads` so it can be resumed. A role file's section structure is
defined by `role-template.md` (and shaped to your discipline by `setup-from-cv`).

## Maintenance
Add detail freely - granularity is the point. The fastest way to enrich the inventory is the
`/cv-tweaker:deepen-role` and `/cv-tweaker:about-me` commands.
