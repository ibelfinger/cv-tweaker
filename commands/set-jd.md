---
description: Store a job description (URL or pasted text) as a new application
argument-hint: [job url, or paste the JD text]
---

You are storing a job description as a new application folder. Work in the user's current
workspace directory.

## 1. Get the JD text

- If the user gave a URL, open it with the Playwright MCP (navigate to the URL, then read the
  page and extract the job description). If the page resists (login wall / bot block) or the
  Playwright MCP is unavailable, ask the user to paste the JD text instead.
- If the user pasted text, use it directly.

## 2. Create the application folder

Derive a slug `<YYYY-MM-DD>-<company>-<role>`: the date from `date +%F`, and a
lowercase-hyphenated company + role from the JD. Then:

```bash
SLUG="$(date +%F)-<company>-<role>"
mkdir -p "applications/$SLUG"
```

If that folder already exists (same company/role today), add a short distinguishing suffix.
Write the cleaned job description as Markdown to `applications/$SLUG/job-description.md`,
including the source URL at the top if there was one.

## 3. Report

Tell the user the folder you created and that it is now the "last JD" - the default target for
`/cv-tweaker:assess-fit`, `/cv-tweaker:generate-cv`, and `/cv-tweaker:generate-cover-letter`.
