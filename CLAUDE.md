# CLAUDE.md

Slide deck for a **20-minute posit::conf 2026 talk**: "The Unreasonable
Effectiveness of Quarto." Canonical title/abstract in `abstract.md` (already
published). No live demos — everything pre-rendered, screenshotted, or embedded.

First of four talks in a "Dashboards" session whose real subject is **data
products**. Use that phrase; it's the session's shared vocabulary.

## Rules for agents

- **Speaker notes are John's.** Every slide carries an EMPTY `::: {.notes}`
  block; he writes them himself. Keep the empty block when you move a slide,
  and don't write talking points into it. (Stripped 2026-08-18.)
- **Keep edits to this file minimal.** A design decision gets one line, not a
  paragraph. Don't narrate the reasoning behind small changes here.
- **Never run `quarto render`** or any render command. Report done; John renders.
- **Never run `git` commands.** John commits and pushes himself.
- Simplicity first; surgical changes; match existing style.
- Paraphrase external sources; no long quotes.

## The thesis: two parts

> **Quarto as an abstraction layer that separates *content* from *format* — and why that matters for working with AI agents.**
> **With Quarto and AI, you can build incredible dashboards (and build them in an efficient way that ensures correctness).**

- **Entanglement is operational, never metaphorical: the content has no
  address.** No file, no line, no cell *is* a given sentence — it's smeared
  across one probabilistic pass. To change it you regenerate everything.
- **Disentanglement = give the content an address.** Agent writes the `.qmd`;
  values that must be exact live in data files and are recomputed, not typed.
- **You can't prompt your way to correctness. You architect it.**

## Files

- `index.qmd` — the deck. Canonical, repo root. `format: lexis-revealjs` — read
  Styling before editing; the syntax is not stock Quarto reveal.
- `svg/` — the five big inline-SVG figures, one `.qmd` partial each
  (`entanglement-1`, `entanglement-2`, `dashboard`, `experiment`, `params`),
  pulled in with `{{< include svg/….qmd >}}`. Each file is its invariants comment
  plus one ```` ```{=html} ```` block; the slide's heading, images and `.notes`
  stay in `index.qmd`. `robustness.qmd` lives here too — not an SVG, but the same
  deal: a slide body too big to read inline.
- `index.html` + `index_files/` — rendered output, committed. Never hand-edit.
- `_extensions/lexis/` — the lexis extension. Don't hand-edit. Two exceptions,
  both pending upstream: the guarded `.inverse` card paint in `lexis.scss`, and
  background-only slides in `lexis.lua` — see Styling.
- `custom.css` — the only local stylesheet.
- `widget-resize.html` — `include-after-body`; dispatches a window resize on
  every slide change so widgets that measured a `display: none` container
  re-layout without a manual refresh. The map iframe uses `data-src` instead.
- `plots.R` — regenerates `images/fig-tokens.png` and `images/africa-map.png`
  (the only generated images). `Rscript plots.R`. Everything else in `images/`
  is a screenshot or export.
- `africa-map.R` — the map on the `Same map, from source` slide. Displayed
  verbatim on that slide, so keep it clean; see the correctness act.
- `data/africa-funding.csv` — that map's amounts and label offsets.
- `data/token_results.csv` — verbatim copy of the blog post's data. Numbers on
  the token slide are computed from it. Change the CSV and re-run; never
  hand-edit the PNG.
- `abstract.md` — canonical title/abstract/bio.

## The palette

Everything comes from `ltc::ltc("minou")` — slides, figure, `plots.R`.

| Hex | Role |
|---|---|
| `#edae49` yellow | content / data |
| `#00798c` teal | format / structure |
| `#d1495b` red | content that changed; also Shiny, raw HTML |
| `#2e4057` navy | ink — every stroke, arrowhead, label |
| `#852f88` purple | your direct action (from `ltc("hat")`, non-minou) |
| `#66a182` green | verdict — **only** the run-3 checkmark on figure slide 1 |
| `#8d96a3` grey | spine — a `Control`/`Cost`/`Correct` word you've already earned |
| `#74aadb` / `#3d7fb5` | Quarto's brand blue and its ink twin — **cost slides only** |
| `#2B579A` | Word's blue — **cost slides only** |

The two blues are the other non-minou exception. They are brand colors, so they
belong to the four cost slides where the coloring is by file-format identity;
everywhere else `[word]{.blue}` is still the figure's teal, which means *format*,
not *Quarto*.

**Fill vs. ink.** Yellow is light: fine as a **fill** with dark text, invisible
as a line or letter (1.6:1). Ink variant `#A77400` = `.amber`, used only where
yellow must be text. Teal and red serve as both. Consequence inside the figure:
**text on teal is white, text on yellow is navy, text on red is white.**
Legibility, not taste — don't "fix" it.

**Yellow appears only as a fill inside both figure SVGs**, never as a line or
letter.

**Where the color is being *taught*, use a chip, not ink.**
`[**these**]{.contentchip}` / `[**this**]{.formatchip}` — the word becomes the
same object as the band, not just the same hue. Longer phrases stay plain
colored text; a chip round a clause reads as a highlighter.

**Hexes live in three places with no shared variable** — `custom.css`, the
inline SVGs in `index.qmd`, `plots.R`. A palette change is a three-file
find-and-replace.

`.blue` / `.red` / `.green` **override** lexis's defaults so `[word]{.blue}` is
the figure's teal.

