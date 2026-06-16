---
description: Interview to deepen one role's inventory file (career/<role>.md)
argument-hint: [role]
---

You are running the per-role deepening interview: a repeatable, adaptive interview that
enriches a single role's inventory file (`career/<role>.md`) into a broad career record.
Re-runnable; the role file is the memory. Work in the user's current workspace directory.

## 1. Prerequisites

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

- If `ROLES:` lists nothing, there are no role files yet. STOP and tell the user to run
  `/cv-tweaker:setup-from-cv` (bootstrap from a CV) or to create one from
  `career/role-template.md` first. Do not proceed.
- Note the `DISCIPLINE:` value. If it is `unknown`, use the `generic` discipline below.

## 2. Pick the role

- If the user named a role (a command argument or in their message), target
  `career/<that-slug>.md`.
- Otherwise pick the THINNEST role from the `ROLES:` lines: the most `open_threads`, ties
  broken by the fewest `lines`. Tell the user which role you are deepening and that they can
  name a different one.

## 3. Load the coverage palette (discipline-aware)

```bash
cat "${CLAUDE_PLUGIN_ROOT}/references/disciplines/<discipline>.md"
```

Use that template's "Interview coverage palette" as your coverage dimensions, and its
"role file (<role>.md) sections" as the sections you write into. (Engineer keeps the
original Tech & architecture framing; generic uses Tools, systems & domain.)

## 4. Interview - adaptive, one question at a time

Read `career/<role>.md`; note rich vs thin sections and the `## Open threads` list; open on
the most promising thin thread. Then:
- Ask ONE question at a time. Chase the signal: when an answer surfaces something meaty (a
  metric, a system, a hard decision), dig with follow-ups; when a thread runs dry, pivot.
- The palette is a coverage guide to keep in view, NOT a checklist to march through.
  Breadth accumulates across runs. ATS keywords are derived from the answers, not
  interviewed for.

## 5. Record honestly

Write ONLY what the user said into the matching sections. No inference or embellishment. If
unsure, ask; never fill gaps with assumptions.

## 6. Wrap (on "done" or diminishing returns)

Write the new material into the role file, update `## Open threads` to reflect what is still
thin, and report what was added and what remains.
