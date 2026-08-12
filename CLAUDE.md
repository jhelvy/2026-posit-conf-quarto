# CLAUDE.md

Slide deck for a **20-minute posit::conf 2026 talk**: "The Unreasonable
Effectiveness of Quarto." Canonical title/abstract in `abstract.md` (already
published). No live demos — everything pre-rendered, screenshotted, or embedded.

First of four talks in a "Dashboards" session whose real subject is **data
products**. Use that phrase; it's the session's shared vocabulary.

## Rules for agents

- **No speaker notes.** Never add `::: {.notes}` blocks. John doesn't use them.
- **Keep edits to this file minimal.** A design decision gets one line, not a
  paragraph. Don't narrate the reasoning behind small changes here.
- **Never run `quarto render`** or any render command. Report done; John renders.
- **Never run `git` commands.** John commits and pushes himself.
- Simplicity first; surgical changes; match existing style.
- Section dividers are **statements, not labels** — never "Act 3" on a slide.
- Paraphrase external sources; no long quotes.

## The thesis

> **Agents should write the source, not the artifact.**

- **Entanglement is operational, never metaphorical: the content has no
  address.** No file, no line, no cell *is* a given sentence — it's smeared
  across one probabilistic pass. To change it you regenerate everything.
- **Disentanglement = give the content an address.** Agent writes the `.qmd`;
  values that must be exact live in data files and are recomputed, not typed.
- **You can't prompt your way to correctness. You architect it.**
- **Two tiers, don't blur them.** Prose stays in the `.qmd` (address = line
  number + diff). Only exact values move to data. The move is "stop asking for
  the artifact," never "extract everything."

❌ **Never name Thariq or reference "The Unreasonable Effectiveness of HTML."**
Can't assume the room read it. **Never explain the title** (it's a genre —
Wigner, 1960). Make the HTML case in John's own voice as the objection, at full
strength, then turn.

❌ **Don't argue for content/format separation. Show it.** Arguing makes the
talk feel like a recap.

Outline: `outline.md`.

## Files

- `index.qmd` — the deck. Canonical, repo root. `format: lexis-revealjs` — read
  Styling before editing; the syntax is not stock Quarto reveal. Both
  entanglement figure slides live in here as inline SVG.
- `index.html` + `index_files/` — rendered output, committed. Never hand-edit.
- `_extensions/lexis/` — the lexis extension. Don't hand-edit.
- `custom.css` — the only local stylesheet.
- `custom.scss` — **dead**, safe to delete.
- `plots.R` — regenerates `images/fig-tokens.png` (the only generated image).
  `Rscript plots.R`. Everything else in `images/` is a screenshot or export.
- `data/token_results.csv` — verbatim copy of the blog post's data. Numbers on
  the token slide are computed from it. Change the CSV and re-run; never
  hand-edit the PNG.
- `abstract.md` — canonical title/abstract/bio.
- `submission.md`, `outline.qmd`, `outline-long.md`, `outline.pptx` —
  historical. Don't take design direction from them.
- `README.md` — **stale**; still names `custom.scss`.

`fig-tokens` differs from the blog version deliberately: Fira Sans Condensed,
minou colors, no per-dot counts, and a bold multiplier right of each
direct-format dot (1× 1.8× 4× 7.2×) computed from the CSV. The x-axis right
expansion (`0.14`) holds those multipliers — shrink it and `7.2×` clips.
`dpi = 192` gives 1920×960, matching the post.

**`images/`** — flat. `handwriting-good-minecraft.png` does double duty (the
drifted sheet in Act 1, the minecraft sheet on the payoff slide); swapping it
changes both. `handwriting-good-mario.png`, `handwriting-practice-minecraft.pdf`
and `africa-correct.png` are unreferenced.

Render status: `index.qmd` has not been re-rendered since the lexis conversion.

## The palette

Everything comes from `ltc::ltc("minou")` — slides, figure, `plots.R`.

| Hex | Role |
|---|---|
| `#edae49` yellow | content / data |
| `#00798c` teal | format / structure |
| `#d1495b` red | content that changed; also Shiny, raw HTML |
| `#2e4057` navy | ink — every stroke, arrowhead, label |
| `#852f88` purple | your direct action (from `ltc("hat")`, the one non-minou color) |
| `#66a182` green | verdict — **only** the run-3 checkmark on figure slide 1 |

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

❌ Don't revisit the palette casually. The test is that content and format stay
distinct under red-green colorblindness (163° apart in minou), not "does it look
nice." When picking an accent, **chroma is the axis that matters, not hue.**

## The entanglement figure

Two slides of inline SVG in `index.qmd` (Act 2). Neither is `{{< inverse >}}` —
the SVG needs a light slide.

```
SLIDE 1 — one loop, stacked 3×, three different documents fall out
   [ me ] ──▶ [ agent ] ──▶ [▓▒▓▒▒▓/] .pdf     bands
      ▲          (dashed)
      └──── review & re-prompt ──┐
   [ me ] ──▶ [ agent ] ──▶ [∴∵∴∵∴/]           dots
   [ me ] ──▶ [ agent ] ──▶ [▪▫▪▫▫/]           blocks

SLIDE 2 — at rest: byte-for-byte slide 1's row 1 (dots)
   click 1: chain opens ±140, .qmd + data fade into the gap,
            artifact dots → bands (row 3, the checked one)
   [ me ] ──▶ [ agent ] ─writes─▶ │ yaml / content │ ─render─▶ [▓▒▓▒▒▓/]
      ├── prompt the agent ──┘     └───────▲────────┘
      └── …or edit it directly ───┘    [▓ data ▓]
   click 2: two purple arrows.  click 3: content yellow→RED, teal doesn't move.
```

**Headings are lexis `#` lines above each SVG, and they are the whole legend:**

```
# [Content]{.contentchip} entangled with [Format]{.formatchip}
# Quarto disentangles [Content]{.contentchip} and [Format]{.formatchip}
```

Slide 2's is slide 1's sentence with two words inserted — change them together
or not at all, and keep both at `#` (see registration).

❌ No swatch legend. The two slides before the figure teach the vocabulary
(concrete: "I want *these* sentences with *this* layout"; then named), and the
figure carries that same sentence across its top.

### Invariants

- **The two slides are REGISTERED.** Both carry `viewBox="0 77 1240 553"`; slide
  2 at rest is byte-for-byte slide 1's row 1 (dots), same coordinates. Advancing
  changes nothing until you click — that stillness earns the "one picture, one
  variable" claim. Slide 2 carries ~280 units of dead canvas below its figure to
  hold this. **Changing either viewBox, either heading level, or that row's
  geometry breaks it — recompute both.** One deliberate exception: slide 2's SVG
  carries `margin-top:50px` so its figure reads centred against all that dead
  canvas, so the two at-rest pictures now sit 50px apart. Drop it, or add the
  same to slide 1, if stillness ever matters more than centring.
- **Motif order is dots → blocks → bands ✓, and it's load-bearing.** Bands is
  the only motif that reads as lines of text on a page, so it's the draw you
  keep (row 3, green check) *and* slide 2's `#docOut`. The scattered motifs are
  the drafts you threw away. ❌ Don't reorder without moving the check and both
  of slide 2's `<defs>` copies with it.
- **Height is the binding constraint, not width.** Slide is 1600×900, padding
  `45px 90px 60px`, usable 1420×795; the heading eats ~100px; the figure renders
  ~633px. ~60px slack. The knob is row spacing (186), never the viewBox width.
- **The artifact is a PAGE with a folded corner, labelled `.pdf`.** 90×116 (US
  Letter), drawn 1:1, outline `M 0 0 L 68 0 L 90 22 L 90 116 L 0 116 Z`, fold
  triangle `M 68 0 L 90 22 L 68 22 Z` in white. Same rect family as the `.qmd`,
  on purpose: same colors, same kind of box, and the **only** variable is
  whether the bands have places. ❌ Not an oval (read as a blob at distance,
  disagreed with the real sheets on the payoff slide). ❌ Not a rounded rect —
  that's the actor shape.
- **Never draw the artifact as content nested inside a format box.** Containment
  implies they're already separate. Always irregular **horizontal** bands
  bleeding edge to edge, clipped to the page. (Nesting inside the `.qmd` is not
  a violation — that's the claim.)
- **The three documents differ in MOTIF** — `#doc` bands, `#docDots`,
  `#docBlocks` — for legibility at distance. Every dot and block sits wholly
  inside the page and clear of the fold (`x ≥ 68`, `y ≤ 22`); only bands are
  clipped. Rows are **unlabelled** — no "run 1/2/3", which invites reading the
  stack as progress.
- **`#loop` is drawn once and `<use>`d three times.** The rows being *provably*
  identical is the argument. **Anything added to `#loop` costs 3×** — the `.pdf`
  label is the one deliberate exception, because it makes slide 2 read
  `.qmd` → render → `.pdf`, which is an explainer slide's work for free.
- **Nothing points from one document to the next.** The only route between rows
  is the dashed *review & re-prompt* connector, landing on `me`. ❌ An arrow from
  run 1 to run 2 would argue iteration converges — the opposite claim.
- **Nothing on slide 1 moves.** ❌ Reversed: run 1 used to slide up on click 1
  (`.lift`, kept commented in `custom.css`). Motion the room parses before the
  point lands.
- **Row 3 carries a green ✓ to its right** — the draw you kept. Outside `#loop`
  (rows stay provably identical), inside run 3's fragment (no extra click), and
  the deck's only green, so it reads as a verdict and never as a third color of
  content. It doesn't touch row 1, so registration with slide 2 is unaffected.
- **Both content AND format are redrawn on every pass.** ❌ Do not hold content
  constant and vary only format: the cold open is pokemon drifting into
  minecraft, so content is exactly what moved. That instinct belongs in Act 6's
  *change one word* (`format: pdf` → `format: html`), not built yet.
- **The agent box is dashed and identical on both slides.** The agent didn't get
  better; the thing it writes did. Don't "improve" it on slide 2.
- **The `.qmd` box is a NEUTRAL container — navy stroke, never teal.** Teal
  would say "format contains content"; navy says "a file contains both." The
  only box in the deck where the two colors nest.
- **The teal band is the YAML**, and it's what Act 6's *change one word*
  changes. The file is not meant to be read.
- **`data` is yellow, sits outside, feeds the `.qmd`** — not render. Data is
  content; only the kind of address differs. **Nothing points at `data`** — it
  comes from the world, and the empty input is the point.
- **Two purple arrows, one forking line.** Both leave `me` at x=255; the second
  starts at the first's corner so they read as one descent that splits. Upper →
  the agent's bottom edge, *prompt the agent to change the .qmd*. Lower → the
  `.qmd`'s bottom edge, *…or edit it directly* (the file, not either block —
  both halves are yours). Both purple: delegating the typing is still your
  action. ❌ Don't cut the agent branch — without it the slide claims
  hand-editing is the only way in, which nobody in that room does. Purple = the
  action, red = the changed content; no color link, the arrows are labelled.
- **`#docDotsOut` is a hand-kept copy of `#docDots`; `#docOut` of `#doc`;
  `#docOutEdited` is `#docOut` with `#edae49` → `#d1495b` and nothing else.**
  Edit one, edit its twin.
- **Slide 2 changes document exactly once, at click 1** — dots (row 1) → bands
  (row 3, checked), as an overlay. It rides click 1 because that's where the
  *route* changes, so a different document is honest. ❌ Never let click 3 change
  the whole page: the edit must change only what you addressed, or the figure
  becomes an argument for determinism. (Moving the swap to index 3 is one
  attribute if John ever wants the edit itself to produce the kept document —
  it costs exactly that claim.)
- **Click 3 = content changes, format doesn't.** Teal bands byte-identical and
  unmoved. The `Content` chip in the heading recolours at the same index so
  legend and figure never disagree. Mechanism is an **overlay**, not a
  fade-out swap (a `fade-out` is visible at rest, which broke once the `.qmd`
  became a fragment).
- **Every arrow: `stroke-width="2.5"`, 80 units, 8-unit gap.** All four markers
  use `refX="5.5"` — `markerUnits` is `strokeWidth`, so at `refX="7"` the butt
  cap pokes through the tip. The visible tip lands 1.5 × stroke-width past the
  path end, and endpoints are written with that subtracted. Change a stroke
  width and re-check every landing gap.

### Coordinates

Closed row: me 340 · agent 540 · artifact 810–900, centred, 340 margin each
side. Rows 186 apart, centred on y = 175 / 361 / 547.

Opened (slide 2, click 1): me 200 · agent 400 · `.qmd` 670 · artifact
950–1040, 200 margin each side, uniform 90-unit gaps. The `.openleft` /
`.openright` CSS rules glide ±140 and **are not optional** — without them the
`.qmd` lands on top of the artifact. 140 = half the 280 the `.qmd` inserts, and
is **independent of the artifact's width**. General rule: shift = 75 + L; the
`.qmd` lands at x=670 whatever L is, so `data` (centred at 765) and the purple
arrow's landing point (690) never need recomputing.

The agent→artifact arrow is nested inside `.openleft` so the one line that says
"entangled" leaves as the file that fixes it arrives.

Each slide carries **its own `<defs>` and `<clipPath>`** (`artifactClip` /
`artifactClip2`) and ids are unique document-wide (`ahDark`/`ahDark2`) —
reveal puts non-current slides in `display:none` and cross-slide `<use>` is
unreliable. The viewBox top (77) is a **crop**, reclaiming the space the old SVG
headings held; coordinates inside are unshifted — don't renumber them.

### Not yet visually vetted

Coordinates are computed by script, never rendered. On first render check:
does slide 1 **fit** (~60px slack); does the 22-unit dog-ear register; are the
dots/blocks legible at 3 columns; do the four `.pdf` labels read as labels
rather than clutter; does the ±140 glide read as *opening* rather than
scattering.

Added since and also unvetted: the green ✓ beside row 3; the dots→bands overlay
on slide 2 click 1 (does the dots page vanish completely under the bands?); the
forked purple arrows — **the label widths are estimated, not measured**, so
check *prompt the agent to change the .qmd* (centred x=420, y=285) clears the
x=255 descent on its left and doesn't run into the `.qmd` box on its right, and
that the two labels don't crowd each other at 24px apart; and whether the 50px
top margin centres slide 2 or just shifts the problem.

## The payoff slide (right after the figure)

**"Same `format`. No drift."** Two columns, each a `.qmd` box over the real
sheet it produces: pokemon and minecraft.

**It is figure slide 2's click, frozen.** pokemon wears the at-rest `content`
yellow `#edae49` + navy text; minecraft wears the post-click red `#d1495b` +
**white** text. Read left to right, it's the animation.

- **What carries it is what doesn't vary.** Same 190×124 `.qmd` box, teal `yaml`
  band byte-identical in both columns. Only the content block differs. Keep the
  two SVGs verified-identical apart from that.
- ❌ Was three columns (pokemon / minecraft green / mario red). Mario is cut.
  Don't "fix" minecraft back to green — green now means *verdict* (the run-3
  checkmark), not a third document.
- ❌ No `render` label under the arrows — the previous slide just taught it.
- These SVGs use **no ids and no markers** (explicit triangle arrowheads), so
  they add nothing to the id namespace. Keep it that way.

## The "one paragraph, three sources" slides (Act 3 lead-in)

Make token efficiency visible before the numbers arrive. Sit after the
"✅ Token efficient" build; `fig-tokens.png` now follows them immediately.

**Slide A — "One paragraph. Three sources."** A rendered paragraph in a bordered
card across the top, then three columns of source: `.qmd`, LaTeX, HTML, with an
exact character count under each. **The card is the referent** — without it the
columns are three unrelated code blocks. Hand-written HTML, styled to read as a
document excerpt, not a slide callout.

**Slide B — "Then there's Word."** Same paragraph as `word/document.xml`, plus
the note that it's one file in a zip that also needs `[Content_Types].xml`,
`_rels/.rels`, `word/_rels/document.xml.rels`, `styles.xml`.

The paragraph is fixed and identical in all four:

```
## EV Sales

Sales of **electric vehicles** grew 20% in 2025, reaching over
_20 million_ sales globally.
```

| Source | chars | × `.qmd` | formatting |
|---|---:|---:|---:|
| the paragraph itself | 93 | — | 0 |
| `.qmd` (with `format: pdf`) | 126 | 1× | 33 |
| LaTeX | 252 | 2.0× | 159 |
| HTML | 377 | 3.0× | 284 |
| OOXML (`document.xml` only) | 663 | 5.3× | 570 |

The card is shown **large and centred** on slide A, then **small at the top** of
slide B above the three columns — same markup, different inline sizes.

- **Counts are measured** (`wc -c`), not estimated. **Edit one character in any
  block and recount all of them** — hand-adjusted numbers on this slide would
  contradict the talk.
- **Column order is smallest → biggest**, and it's the same order as the token
  data (Markdown 1,267 · PDF 1,992 · HTML 4,046 · Word 8,097). The character
  slides *predict* the chart. **HTML costing more than LaTeX is not a bug.**
- **Column 1 is a real `.qmd`, YAML and all** — otherwise the other two carry a
  preamble and it doesn't, which is an open objection. The answer if it comes
  up: the styling moved into the renderer. ❌ Don't "even things up" by stripping
  the LaTeX and HTML columns; minimal-valid HTML would gut the slide.
- ❌ Don't add a second `.qmd` column showing `format: html` — that spends Act
  6's callback early.
- **PDF is shown as LaTeX**, labelled `PDF (via LaTeX)`. Raw PDF object syntax
  is a strawman; an agent asked for a PDF writes LaTeX.
- **Colors escalate with cost:** teal (`.blue`) Quarto → amber (`.amber`, the
  yellow ink variant — plain yellow is 1.6:1) PDF → red HTML, red Word. Label
  and count share the column's color. ❌ Don't reach for the content/format
  chips here — this slide is about cost, not entanglement.
- **Slide B and the Word slide share one layout:** colored label above the code
  block, count in the same color below it.
- **`.font45` wraps only the code block, inside a `:::: {.col}`.** `.fontNN`
  divs **compound**, so a `.font140` count line inside a `.font45` column would
  render at 63%.
- **All three columns share one type size** — the lengths are the argument. If
  slide A overflows, take all three down together (HTML is tallest at 17 lines).
- ❌ Don't moralize about the syntax. HTML and LaTeX are good formats; the claim
  is only that the agent pays for every character.

## The dashboard case study (Act 4)

**vehicletrends.us** — source at `/Users/jhelvy/gh/vehicletrends/dashboard`. A
real, multi-page, self-updating Quarto site over 10M+ listings. Draw principles
from the real repo, never invented ones.

1. **Same move, at scale.** Agent writes the `.qmd` + small R chunks; **data
   lives in an external R package** (`vehicletrends`) the pages read at render
   (`setup.R`). Weekly GitHub Action re-renders, so nothing goes stale.
2. **Shiny asks for the artifact; Quarto asks for the source.** THE objection to
   pre-empt in this room. Shiny = UI + inputs/outputs + server + reactivity.
   Quarto = markdown + a chunk returning a self-contained JS widget. Honest
   concession: server-side compute over browser-too-big data is Shiny's turf.
3. **Isolate heavy components behind an iframe.** The MapLibre + PMTiles map is
   a separate repo (`hhi-map`), dropped in with 6 lines. Same for Shinylive.
4. **Small pieces have small context windows.** Efficiency made architectural.
5. **It's just static files.** Charts, map, even the Shiny app (Shinylive →
   WASM) run client-side. No server to run, secure, or pay for.

Tech: `echarts4r`, `reactable`, MapLibre GL JS + PMTiles (Cloudflare R2,
Tippecanoe via `{pmtiles}`), Shinylive/webR, GitHub Actions, GitHub
Pages/Netlify. **Don't invent pitfalls** — get real ones from John.

## Styling

`index.qmd` uses the **`lexis-revealjs` extension** (`_extensions/lexis/`, from
`jhelvy/quarto-lexis`). Authoring differs from stock Quarto reveal:

- **`---` starts every slide.** `#`/`##`/`###` are text sizes *within* a slide
  (`slide-level: 0`).
- **Slide modifiers are shortcodes:** `{{< inverse >}}` `{{< center >}}`
  `{{< middle >}}` `{{< bg-color >}}` `{{< bg-image >}}` `{{< no-slide-number >}}`.
  Divider slides = inverse+center+middle + a `#` heading.
- **Columns are consecutive `::: {.col}` divs**, no wrapper. Uneven via
  `width="55%"`. Nest with `::::` when a column contains its own div.
- **No auto title slide** — hand-authored using `{{< meta title >}}`.
- **Utility classes:** colors, `.small .large .font10`–`.font200`, `.fancy`,
  `.fira`, image helpers (`.border .circle .polaroid .thumbnail`),
  `::: {.panel-tabset}`.
- **Full reference: the `/lexis` skill.** `/lexis-clean` audits a deck.

`custom.css` is loaded via the **nested** format key — this is load-bearing, and
for a long time the key was absent so every rule in the file was silently dead.
If a class "doesn't work," check this YAML first:

```yaml
format:
  lexis-revealjs:
    css: custom.css
```

`custom.css` holds only what lexis doesn't ship, plus the palette overrides:
`.amber`, the `.blue`/`.red`/`.green` repoints, `.contentchip`/`.formatchip`,
`.amberborder`/`.blueborder` (wrapper-div pattern — `::: {.col .blueborder}`,
not an image attribute block), `.openleft`/`.openright`, and a commented-out
`.lift`. Its header comment restates the palette; keep the two in sync.

## Open / to do

- **Visually vet the entanglement figure** — see the checklist above.
- **Say one sentence defining Quarto out loud** while figure slide 2 is up:
  plain-text document, markdown with code, `quarto render` turns it into a PDF
  or a site or these slides. ~8 seconds. ❌ No dedicated explainer slide.
- **Build Act 6's *change one word* slide** — `format: pdf` → `format: html`,
  content unchanged. Not built.
- **Produce remaining demo assets** (still `> **[BRACKETED]**` in `index.qmd`):
  silent dashboard screen recording (~75s); MapLibre map screenshot; the live
  inline interactive chart; the multi-turn token chart.
- **Multi-turn token data** — placeholder. The single-shot table is in the deck
  (Word 8097→1121, HTML 4046→1022, PDF 1992→1123, Markdown 1267→1282). The
  multi-turn numbers aren't published yet. **Never invent them.** Frame as the
  measured version of the Act 1 anecdote, not a second benchmark.
- **Verify hosting claim** — deck says GitHub Pages; the dashboard's
  `tech-stack.qmd` says Netlify. Confirm before presenting.
- **Refresh `README.md`** — still names `custom.scss`, doesn't mention lexis.
- **Optional "what bit me" slide** — only with real pitfalls from John.
- Optional: compare notes with the three co-speakers (Blake's talk is also
  AI-adjacent; check the setup slides don't collide).
