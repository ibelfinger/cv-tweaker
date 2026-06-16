# CV & cover-letter guidelines (universal)

Non-personal house style for every generated CV and cover letter. Referenced by the
generate-cv, generate-cover-letter, and assess-fit commands.

## Honest reframing only
Everything on a CV or letter must trace to `career/`. Never fabricate roles, metrics,
skills, or scope. Mirror a job description's terminology only where it truthfully describes
what the person did.

## Two-page fit: overshoot-then-trim
The CV target is two full pages. `build.sh` prints the page count after each compile and
warns when it exceeds the target. Drive by that page count, not a bullet number (the layout
is dense - a full two pages is roughly 28-32 bullets plus a Community line).

1. Overshoot for real: add genuine bullets - recent / most-relevant roles ~6-7+, pulling
   architecture/metrics/decisions/leadership from the deepened `career/*.md`, plus a
   Community credential line - until `build.sh` actually reports 3 pages.
2. Trim the least-valuable bullets - oldest roles first, then weakest/redundant - and
   recompile.
3. Stop the instant it drops to a full two pages. If genuinely strong content runs out
   before 3 pages, stop there. Never pad with filler.

## Earlier Experience (collapsing older roles)
When there are many roles, collapse the oldest / least-relevant into a single compressed
"Earlier Experience" block - one line each (company, title, dates, one line). Recent roles
keep full bullets. Where to draw the line is per-person: ASK the user where to cut when
there are a lot of roles. Do NOT assume a fixed year.

## Contracts
Short contracts are always labelled "(Contract)". Per the JD, feature or omit them; never
show a short contract as a prominent unlabelled full-bullet entry.

## Honest omissions
A short or unsuccessful stint (e.g. a role left during probation) may be omitted entirely -
that is honest. Never relabel or misrepresent it (e.g. dressing a permanent role up as a
contract) to make it fit.

## Formatting (ATS-safe)
- Single-column. Technical Skills as labelled one-line-per-category (no two-column /
  minipage; ATS parsers scramble columns).
- No em-dashes anywhere (no "---", no literal em-dash); use "-" or restructure.
- "Approximately" = `$\sim$`, never `\textasciitilde` (renders a raised glyph).
- LaTeX-escape literal `%`, `$`, `&`, `#`, `_` in content.

## No invention of contact/education
Contact and education are fixed in `00-profile.md`; never invented per application.
