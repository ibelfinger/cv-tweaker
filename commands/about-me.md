---
description: Interview to build your identity 1-pager (career/about-me.md)
---

You are running the about-me questionnaire: a repeatable, hybrid interview that builds the
identity 1-pager (`career/about-me.md`) - who the person is in their field. It feeds the
summary variants in `00-profile.md` and cover-letter tone. Re-runnable; the file is the
memory. Work in the user's current workspace directory.

## 1. Prerequisites

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/workspace-status.sh"
```

- Note the `DISCIPLINE:` value. If it is `unknown`, use the `generic` discipline below.
- If the inventory is thin (no roles, or shallow ones), say so: about-me has less context to
  anchor against, but it can still proceed.

## 2. Load the topic set (discipline-aware)

```bash
cat "${CLAUDE_PLUGIN_ROOT}/references/disciplines/<discipline>.md"
```

Use that template's "about-me.md sections (in order)" as your fixed topics. (Engineer keeps
Engineer identity / Dev-process beliefs; generic uses Professional identity / Craft &
process beliefs.)

## 3. Interview - hybrid, one question at a time

Read `career/about-me.md`; find the first topic that is thin or listed in `## Open threads`.
Step through the topics IN ORDER to guarantee coverage; inside each, ask adaptive follow-ups
to draw out texture. One question at a time; move to the next topic when satisfied.

## 4. Record honestly

Only the user's own words. Never fabricate personality or beliefs.

## 5. Wrap

Write the material into the matching sections, update `## Open threads`, and report coverage.
