# Plan: Act 4 (Correctness) and Act 5 (The Dashboard)

Status: **implemented** in `index.qmd`. This file records the design decisions and
the facts each slide rests on, so they can be checked before the talk.

## Context

The deck stopped mid-thought. Slide 23 was literally `[Left off here]`, and everything
after it was half-built material in the wrong order:

- The two Africa images had no headings, no captions, and mismatched widths (80% / 40%),
  so they did not read as a pair.
- The divider `# Easy to deploy (serverless)` was a label, which the project rules
  forbid — section dividers are statements.
- `Put it in a box`, `Small pieces`, and `It's just static files` all discussed "the
  dashboard" the audience had never been shown. vehicletrends.us was named nowhere.
- `HTML can't tell you it's broken` and `Checkable twice` are the *answer* to the Africa
  map, but sat after the dashboard act, orphaned from the question.

This is a Dashboards session, so the vehicletrends walkthrough has to be real and has
to land.

## The arrangement

Was: `[Left off here]` → Africa (bare) → dashboard → trust → close.
Now: **Africa → trust → dashboard → close.**

This follows the escalation already written in `outline.md`: a kid's worksheet → a
government slide with every country wrong → a live dashboard. Stakes climb, the
dashboard is the climax, and the deck ends on the session's own topic. The
`vehicletrends.gif` cold open becomes a bookend when it replays as the payoff.

Deck is now 44 slides.

---

## Act 4 — Correctness (slides 23–28)

| # | Slide |
|---|---|
| 23 | Divider: **Control is one thing. Correct is another.** |
| 24 | `africa-bad.png` — the artifact in the wild |
| 25 | `africa-good.png` + BBC source credit |
| 26 | **That map rendered fine** — drawn vs. joined |
| 27 | **But HTML can't tell you it's broken** (moved up) |
| 28 | **Quarto is checkable twice** (moved up) |

**The Africa slides never claim who or what made that map.** No source establishes it
was AI-generated; the BBC graphic says only "mislabels." The slides claim what the map
*demonstrates* — a wrong artifact looks exactly like a right one. It rendered, it
shipped, nobody caught it. That holds regardless of authorship, and it is a better
setup for the two compile-step slides than an authorship claim would be.

Source credited on slide 25: <https://www.bbc.com/news/articles/c89n0xykw2go>. The
graphic's own caption dates the original to a State Department presentation in Brazil,
26 July 2026.

Both images are now sized by **height** (620 / 660), not width — one is 16:9 landscape
and the other 3:4 portrait, so equal widths made them read as unrelated images.

Slide 26 is the turn, and it earns its own slide because it is Act 2's thesis applied
to data: join country names to a shapefile and a wrong name *fails*; draw the shape and
there is nothing to fail.

---

## Act 5 — The dashboard (slides 29–39)

Every claim traces to `/Users/jhelvy/gh/vehicletrends/dashboard`.

| # | Slide | Rests on |
|---|---|---|
| 29 | Divider: **Same move. Bigger artifact.** | — |
| 30 | `vehicletrends.gif`, full-bleed | replays the cold open |
| 31 | **vehicletrends.us** + the numbers | `about.qmd:11–16` |
| 32 | **It's a Quarto website** | `_quarto.yml`, `setup.R`, `DESCRIPTION` |
| 33 | **Every page gets a URL** | 10 sidebar entries |
| 34 | **No UI. No server.** | the Shiny objection |
| 35 | **"But I need users to filter it"** — live chart | `vehicletrends::percent_listings` |
| 36 | **Put it in a box** | `market-concentration.qmd:115`, `hhi-map` |
| 37 | **Or drop a whole Shiny app in the page** | `hhi-explained.qmd`, `registrations.qmd` |
| 38 | **Small pieces have small context windows** | page line counts |
| 39 | **It's just static files** | `.github/workflows/main.yml` |

### Facts used

- **169,552,665 listings** = 74,894,001 new + 94,658,664 used; 100,000+ dealerships;
  2018–2025. The previous "10M+" in our notes was wrong by 17×. `about.qmd` computes
  these at render time and inlines them with `` `r n_new` `` — so the case study's own
  source states the talk's thesis, which is why the exact number is on the slide rather
  than "about 170 million."
- **15 pages, ~2,900 lines of `.qmd`.** Biggest page is 620 lines; `index.qmd` is 6.
  This is what makes the small-context-window claim concrete: the agent opens one page,
  never the site.
- **Data lives in an external R package.** `setup.R` is `library(vehicletrends)`;
  `DESCRIPTION` carries `Remotes: vehicletrends/vehicletrends`.
- **The map**: `hhi-map` is 276 lines of hand-written MapLibre in its own repo, and
  `hhi_tracts.pmtiles` is 1.64 GB on Cloudflare R2. That is precisely what should not
  live in a `.qmd`, and the iframe that embeds it is 4 lines.
- **Shinylive**: two pages are native `{shinylive-r}` chunks compiled to WebAssembly.
  This is the same move as the iframe, which is why it sits immediately after it — and
  it resolves the honest concession made on slide 34.
- **Weekly re-render**: `cron: '0 5 * * 0'`. The `gh-pages` branch proves it is running —
  "Built site for gh-pages" on 2026-08-09, 08-02, and 07-26, exactly 7 days apart.
  There is **no `freeze`**, so every build re-executes all the R. Nothing is cached, so
  nothing goes stale.

### The live chart (slide 35)

The deck is HTML, so the chart is real and interactive — the demo *is* the slide. No
demo time, no screen switching, and it proves the claim rather than asserting it.

The example is **category filtering via the interactive legend**, because that is the
single most common reason people reach for Shiny: a `selectInput` wired to a reactive
that redraws a chart. Here it is one series per powertrain and a click. Gasoline sits
at ~91% and flattens everything else, so clicking it off is a genuinely useful action,
not a toy one.

Data is `vehicletrends::percent_listings` filtered to powertrain share of new listings,
2018–2025. Chart code verified to build before it went in the deck.

**This is the deck's only render-time R dependency besides `plots.R`:** `{dplyr}`,
`{echarts4r}`, `{vehicletrends}` (installed at 0.4.6 / 0.0.6).

### Open question: hosting

**Do not name the host on a slide yet.** The workflow publishes to `gh-pages`, but
`tech-stack.qmd` and `README.md` both say Netlify, and there is no `netlify.toml`, no
`_publish.yml`, and no `CNAME` anywhere — including on the `gh-pages` branch. A Netlify
site can be configured entirely in Netlify's UI, so the filesystem cannot settle this.
Slide 39 currently says only "hosted for free." Confirm what answers for
vehicletrends.us at the DNS level before writing a host name.

---

## Also changed

- `index.qmd:1049` — removed a stray trailing `l` on `` `styles.xml` ``.
- `CLAUDE.md` — new Act 4 section; dashboard section renumbered to Act 5 and corrected;
  removed the stale `africa-correct.png` reference (that file does not exist).
- `outline.md` — "10M records" corrected to 169,552,665.

## Still open

- `# Close` (slide 40) is still a label divider, the same violation as the old
  serverless one. Needs a statement.
- 44 slides for 20 minutes — worth a timed run.
- Act 6's *change one word* slide (`format: pdf` → `format: html`) is still unbuilt.
- ~~The multi-turn token chart~~ — built, then **cut**. `d` cancels, so the chart
  was `fig-tokens` rescaled: same ratios at turn 1 and turn 10, no new shape. The
  point is verbal now (80,970 vs. ~11,000 after ten edits). No bracketed
  placeholders remain in the deck.

## Verification done

- All 44 slides parse; `:::` div fences balance on every slide; no unterminated code
  fence.
- No `::: {.notes}` block was added (the existing ones predate the no-notes rule).
- The echarts4r pipeline was run standalone and produced a widget before being added.
- Not rendered — John renders.
