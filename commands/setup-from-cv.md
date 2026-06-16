---
description: Bootstrap the career inventory from an existing CV found in the workspace
---

You are bootstrapping a cv-tweaker workspace's career inventory from the user's existing CV.
This is the unavoidable foundation step. Work in the user's current workspace directory.

## 1. Guard against clobbering

Run the status helper and read it:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

If `PROFILE: filled` or any role is listed under `ROLES:`, the inventory is already
populated. STOP and tell the user, listing what exists. Only proceed if they EXPLICITLY
confirm a clean re-bootstrap (which overwrites `00-profile.md` and re-creates role files).

## 2. Find the CV

Look for a CV file, in order: `_seed/` first, then elsewhere in the workspace. Accept PDF,
Markdown, or plain text.

```bash
ls -1 _seed/ 2>/dev/null; echo "---"; ls -1 *.pdf *.md *.txt *.tex 2>/dev/null
```

- No CV found: STOP and ask the user to drop their existing CV into `_seed/`.
- A `.docx` only: ask the user to export a PDF or text version (you cannot reliably read docx).
- Multiple candidates: ask the user which one is their CV.

Read the chosen CV with the Read tool (it handles PDF, Markdown, and text).

## 3. Detect discipline and load the template

From the CV's titles, responsibilities, and skills, decide the discipline:
- Clearly software engineering / engineering leadership -> `engineer`.
- Anything else (product, program/project management, design, data, ops, marketing, ...) ->
  `generic`.

State your judgment to the user in one line. Then load the matching template:

```bash
cat "${CLAUDE_PLUGIN_ROOT}/references/disciplines/<discipline>.md"
```

Use that template's section lists VERBATIM for the files you write below. Do not invent
structure.

## 4. Write the inventory (honest; only what the CV says)

Record ONLY what the CV actually contains. Where the CV is silent, leave the template's
`[...]` prompt in place and add the gap to that file's `## Open threads`. Never invent.

- **`career/00-profile.md`** - fill Contact (name, a headline matching the discipline's
  framing, `**Discipline:** <discipline>`, location, phone, email, LinkedIn), one or two
  Summary variants, the Master skills list, the skills bank, Education, Languages, and
  Community & recognition - all from the CV.
- **One `career/<role>.md` per job** in the CV (slug = lowercase-hyphenated company, e.g.
  `career/acme.md`), using the discipline template's role-file sections, populated with the
  CV's (shallow) data for that job. Seed `## Open threads` with the sections the CV could not
  fill (usually most of them) so `deepen-role` has a starting point.
- **`template/skeleton.tex`** - replace the header placeholders (`[FULL NAME]`, the headline,
  contact line, and the Education/Languages constant sections) with the CV's real values.
  LaTeX-escape `%`, `$`, `&`, `#`, `_`.
- **`career/role-template.md`** - if the discipline is not the scaffold default, rewrite this
  local skeleton to the discipline template's role-file sections so future hand-created roles
  match.

## 5. Report

List the role files created, confirm the profile and `skeleton.tex` header are filled, and
give next steps:
- `/cv-tweaker:deepen-role` to enrich each role (the CV gave only shallow data).
- `/cv-tweaker:about-me` to build the identity 1-pager.
- The inventory is the source of truth; everything a CV says must trace back to it.
