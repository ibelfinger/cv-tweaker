# LaTeX template

`skeleton.tex` is the reusable style for every tailored CV. It contains the full
preamble, the navy/accent color palette, list styling, the constant header
(name, title, contact), and the constant Education/Languages sections. The
variable sections carry `% <<MARKER>>` insertion comments.

## Custom commands

- `\jobheading{Company (Location)}{dates}` — accent-colored company line with a
  right-aligned bold date range and a thin rule beneath.
- `\jobtitle{Title}` — bold job title (place on its own line after a heading).
- `\companyname{Name}` — accent-colored inline company name (used when several
  companies share one heading, e.g. advisory engagements).

## Insertion markers

| Marker | Replace with |
|---|---|
| `% <<SUMMARY>>` | Tailored summary variant from `career/00-profile.md`. |
| `% <<SKILLS>>` | Pipe-separated skills line, ordered to match the JD. |
| `% <<EXPERIENCE>>` | `\jobheading` + `\jobtitle` + `itemize` blocks per role. |
| `% <<TECHSKILLS>>` | Single-column, ATS-safe labelled tech-category lines (one per line). |
| `% <<COMMUNITY>>` | Verifiable credentials (mentorship, talks, OSS, awards); helps fill page 2. |

To generate a CV: copy `skeleton.tex` to `applications/<slug>/cv.tex`, replace
each marker, then run `./build.sh applications/<slug>`.

## Compiling

`pdflatex` (at `/Library/TeX/texbin/pdflatex`) is required; `helvet`/`\sfdefault`
means xelatex is not needed. `build.sh` runs it twice and removes byproducts.

## Escaping

LaTeX-escape literal `%`, `$`, `&`, `#`, `_` in content (e.g. `60\%`, `\$1.5M`).
