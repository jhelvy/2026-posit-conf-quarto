# CLAUDE.md

Project instructions for this repo. **This file is the single source of truth.**
It is also the only surviving record of *why* the talk is shaped this way — the
old `HANDOFF.md` and `talk-framing-decision.qmd` are both gone, so the "Reversed
decisions" section below is the whole rationale. Don't delete it to save space.

## What this repo is

The slide deck for a **20-minute posit::conf 2026 talk**:
**"The Unreasonable Effectiveness of Quarto"** (canonical title + abstract in
`abstract.md` — already published in the program). Audience is Quarto-literate.
**No live demos** — everything is pre-rendered, screenshotted, or embedded
directly in the slides (embedded interactive HTML is itself evidence the approach
works).

**Session placement:** first of four in a session labeled "Dashboards," whose real
subject is **data products** (the other talks: Tableau→AI-ready data products;
custom catalogs for data products; template→package→app). This talk is the
session's thesis statement and its on-ramp. Use the phrase "data product" — it's
the session's shared vocabulary.

## The thesis

**Spine sentence, said 3× in the deck:**
> **Agents should write the source, not the artifact.**

- **Entanglement** is defined *operationally*, never metaphorically:
  **the content has no address.** In a generated document there is no file, no
  line, no cell that *is* a given sentence — it's smeared across one probabilistic
  pass. To change it you regenerate everything and hope. The audience test is
  "can you point at it?"
- **Disentanglement = give the content an address.** A CSV row is an address. The
  agent writes the `.qmd` (structure/logic); content that must be exact lives in
  data files and renders deterministically.
- **You can't prompt your way to correctness. You architect it.**
- **The turn (Act 3): reproducibility used to be a tax; now it's the discount.**
  Token efficiency is *evidence for this*, never a standalone pillar. The virtuous
  path became the lazy path.
- **Two tiers, and don't blur them.** Prose stays in the `.qmd` — its address is a
  line number and a readable **diff**. Only *values that must be exact* live in
  data + code, where they're **recomputed** rather than typed. The move is
  **"stop asking for the artifact,"** never "extract everything."
- The **handwriting-sheet-for-my-6-year-old** PDF is the emotional/legible center.
  Keep it — but note its sentences genuinely *are* data (a list of items to
  typeset). **Never generalize from it to "put your prose in a CSV"** — nobody
  writes that way and the room will reject it. `index.qmd` has a slide that
  pre-empts exactly this objection; don't delete it.
- **Rhetorical rule, used throughout: name the objection first.** Act 1 pre-empts
  "we already knew that"; Act 5 pre-empts "why not just ask for HTML?"

### Reversed decisions — do not reintroduce

- ❌ **No three-pillar framing** ("Correctness / Efficiency / Trust"). A benefits
  list has no tension and reads as a recap to a room that already loves Quarto.
  Those three ideas survive as *earned consequences* (problem → turn → mechanism),
  not as announced categories.
- ❌ **Never name Thariq or reference "The Unreasonable Effectiveness of HTML."**
  Can't assume the room has read it, and naming an unknown rival costs exposition
  and makes the talk dependent on someone else's post. The title is a genre
  (Wigner, 1960) and stands alone — **never explain the title.** Make the HTML
  case in JP's own voice as the objection, at full strength, then turn.
- ❌ **No stale-report slide** ("the numbers changed and the report didn't"). That's
  the knitr elevator pitch since 2012 — the single most "we already knew that"
  moment available. Cut.
- ❌ **Don't argue for content/format separation.** Show it. The room grants it
  instantly; arguing for it is what makes the talk feel like a recap.

## Structure (six acts, ~18 min of content)

| Time | Act | Content |
|---|---|---|
| 0:00–2:30 | **1. The problem, unnamed** | Handwriting sheet cold open. No thesis, no agenda. It drifted; fixing one sentence regenerated everything. → *"Where is the sentence?"* → the defusing line |
| 2:30–5:30 | **2. The move** | Entanglement = no address. The figure (2 slides). The three-sheet payoff. Spine sentence (1/3). *Architect, don't prompt* |
| 5:30–7:30 | **3. The turn** ⭐ | *"And here's what I didn't expect — it's also cheaper."* Token table as evidence. **Tax → discount** |
| 7:30–13:30 | **4. Scale it** ⭐ | The **vehicletrends.us** dashboard, 6 min, mid-deck so overrun can't reach it. Recording → "handwriting sheet at scale" (agent wrote source, never the data) → **"why not Shiny?"** (Shiny = build the artifact; Quarto = write source, browser renders) → iframe isolation / small context windows → "it's just static files" → spine (2/3) |
| 13:30–16:00 | **5. Why it converges** | "So why not just ask for HTML?" — steelman it, live inline chart, *this deck is a `.qmd`*, then: **HTML can't tell you it's broken; `.qmd` has a compile step.** Checkable by machine + human. Caveat |
| 16:00–18:00 | **6. Close** | Change one word. Monday practicum (3 lines). *Software solved this decades ago.* Spine (3/3). Hand off to the session |

## Files

**The deck — the only thing that gets presented.**

- `index.qmd` — the deck. Canonical, lives at repo root. Uses
  `format: lexis-revealjs` — **read the Styling section before editing it**, the
  slide syntax is not stock Quarto reveal. **The entanglement figure now lives
  inside this file** as two hand-written inline-SVG slides (see below); there is
  no separate figure document any more.
- `index.html` + `index_files/` — rendered output, committed to the repo. Stale
  between John's renders; never hand-edit, never read it as the source of truth.
- `_extensions/lexis/` — the lexis format extension (installed, do not hand-edit).
- `custom.css` — the deck's only local stylesheet. See Styling.

**Talk prose (not slides).**

- `abstract.md` — canonical title + abstract + bio. Already live in the program.
- `submission.md` — the original conference submission, under a **different,
  superseded title** ("The Multi-page Dashboard Framework You Didn't Know You
  Had"). Historical; `abstract.md` wins.
- `README.md` — short repo readme. **Stale**: still says the theme is
  `custom.scss` and describes no extension.

**Planning material — historical, do not take design direction from it.**

- `outline.qmd` — an **earlier draft deck**, also `lexis-revealjs`. Superseded by
  `index.qmd`; kept for reference. Its rendered `outline.html` / `outline_files/`
  have been deleted from the working tree (still tracked, deletion uncommitted).
- `outline-long.md` — the full six-act outline the deck was built from.
- `outline.md` — loose notes and open questions. Predates several reversed
  decisions; treat as scratch.
- `outline.pptx` — an export, not a source.

**`images/` — every asset the deck references, flat, no subdirectories.**

| File | Used by |
|---|---|
| `handwriting-practice-pokemon.{png,pdf}` | Act 1 cold open — the original |
| `handwriting-good-minecraft.png` | Act 1 — the drifted version, eight rounds later |
| `handwriting-good-{pokemon,minecraft,mario}.png` | Act 2 payoff — the three-sheet slide |
| `handwriting-practice-minecraft.pdf` | **png is gone**; only the pdf survives, nothing references it |
| `vehicletrends.gif` | the teaser slide right after the title |
| `fig-tokens.png` | Act 3, token cost |
| `africa-bad.jpeg` | Act 5 |
| `africa-correct.png` | **currently unreferenced** by `index.qmd` |

Note `handwriting-good-minecraft.png` does double duty: it is both the *drifted*
sheet in Act 1 and the *minecraft* sheet in the Act 2 payoff. That's fine — same
artifact, two arguments — but if Act 1 ever needs a visibly worse sheet, don't
just swap the file, it will change the payoff slide too.

Render status: `index.qmd` **has not been re-rendered** since the lexis
conversion, the `css: custom.css` fix, or the entanglement figure being ported
in. John renders; agents do not.

## The dashboard case study (Act 4)

Canonical evidence: **vehicletrends.us** — source at `/Users/jhelvy/gh/vehicletrends/dashboard`.
A real, multi-page, self-updating Quarto website (10M+ vehicle listings). It
instantiates the whole thesis, so Act 4 draws its principles from the real repo,
not invented patterns. The five that carry the act:

1. **Same move, at scale.** Agent writes the `.qmd` + small R chunks; the **data
   lives in an external R package** (`vehicletrends`) the pages read at render
   (`setup.R`). Every number has an address; a weekly GitHub Action re-renders so
   the site is never stale.
2. **Shiny asks for the artifact; Quarto asks for the source.** THE objection to
   pre-empt in a Posit dashboards room. Shiny = specify UI + wire inputs/outputs +
   server + reactivity (lots of writing, lots of tokens, a server to run). Quarto =
   markdown + a chunk that returns a self-contained JS widget (ECharts) that runs
   client-side. The PDF problem one level up. Honest concession: server-side
   compute over browser-too-big data is Shiny's home turf.
3. **Isolate heavy components behind an iframe.** The hardest thing on the site —
   the MapLibre + PMTiles census-tract map — is a **separate repo** (`hhi-map`),
   built/iterated alone, dropped in via a 6-line iframe. Also how the Shinylive
   app and Posit Connect charts embed.
4. **Small pieces have small context windows.** Isolation is the *efficiency*
   argument made architectural: the whole dashboard is never in the agent's scope
   at once, so each interaction stays cheap and each component individually
   correct.
5. **It's just static files.** Charts (ECharts JS), the map (PMTiles on a CDN),
   even the Shiny app (**Shinylive** → WebAssembly, no server) all run in the
   browser and deploy free to GitHub Pages. No server to run, secure, or pay for.

Tech specifics for accuracy: charts = `echarts4r`; tables = `reactable`; map =
MapLibre GL JS + PMTiles (Cloudflare R2, Tippecanoe via the `{pmtiles}` R pkg);
in-browser app = Shinylive/webR; CI = GitHub Actions (push + weekly); hosting =
GitHub Pages / Netlify. Don't invent pitfalls — if the deck needs a "what bit me"
slide, get the real ones from John.

## The entanglement figure

**Settled: the figure is IN, and it is TWO slides**, both inline SVG living
directly in `index.qmd` (Act 2, right after "Where is the sentence?"). Neither is
`{{< inverse >}}` — the SVG uses white fills and near-black strokes and needs a
light slide.

```
SLIDE 1 —  content/data ENTANGLED WITH structure/format   (one loop, stacked 3×)
   [ me ] ──▶ [ agent ] ═══════▶  ▓▒▓▒▒▓▓▒            stripes
      ▲          (dashed)
      └──── review & re-prompt ────┐
   [ me ] ──▶ [ agent ] ═══════▶  ∴∵∴∵∴∵∴             dots
      ▲                                                 same loop,
      └──── review & re-prompt ────┐                    different weave
   [ me ] ──▶ [ agent ] ═══════▶  ▪▫▪▫▫▪▪             blocks

SLIDE 2 —  Content NO LONGER ENTANGLED WITH Format
                                     ┌ .qmd ──────┐
   [ me ] ──▶ [ agent ] ──writes──▶  │ ▒▒ yaml ▒▒ │ ──render──▶ ▓▒▓▒▒▓▓▒
      │          (dashed)            │ ▓▓content▓▓│            click 2:
      └──── you edit directly ─────▶ └─────▲──────┘            ▒▓▒▓▓▒▒▓
                                        [ data ]          amber→green, blue fixed
```

**Both headings are colored SVG `<tspan>`s, not labels, and they are the whole
legend.** Slide 2's is slide 1's sentence with two words inserted — that echo is
the point, so change them together or not at all. The color vocabulary is taught
by the two slides *before* the figure and never re-explained inside it:

1. **concrete** — "I want [*this*]{blue} layout, with [*these*]{amber}
   sentences", over the two handwriting sheets in matching colored borders;
2. **named** — "Everything I ask an agent for is two things":
   `content / data` (amber) and `structure / format` (blue), closing on *"ask
   for the document, and they come back **entangled**"*;
3. **the figure**, carrying only that closing sentence across its top.

Don't reintroduce a swatch legend. There was one; at 17px it was unreadable from
the back, and it duplicated in miniature what step 2 already says at full size.

Design rules, in force:

- **Never draw the OUTPUT as content nested inside a format box.** Containment
  implies the two are already separate and in their own places, which is the
  visual opposite of entanglement. The rendered document is always a **striped
  bar** — irregular stripes, content and format interleaved, no boundaries.
  (Scope matters: nesting inside the **`.qmd`** on slide 2 is not a violation, it
  is the claim — see below. The rule is about the artifact, not the source.)
- **Color vocabulary (never break it):** amber = **content**, blue =
  **format/structure**, green = **human's direct action**. Green appears on slide
  2 only, and is the only new color there.
- **The agent box is identical and dashed on both slides.** Dashed = stochastic.
  It is deliberately *unchanged* between them: the agent did not get better, the
  thing it writes did. Don't "improve" the agent on slide 2.
- **Slide 2's left-hand composition mirrors slide 1's** — same boxes, same
  positions — so the pair reads as one picture with one variable changed.
- Its job in Act 2 is **generalization, not explanation** — the handwriting sheet
  already taught the idea. That justifies a simple picture.

**Slide 1 shows variance by stacking the same loop three times.** (This replaces
an earlier swap-in-place build, where three documents shared one slot and
replaced each other. It was too subtle to read from the back of the room — the
only thing that changed was stripe widths inside a small box.) Now: at rest, one
loop, centered. Click 1 lifts it to the top third and run 2 arrives beneath it;
click 2 adds run 3.

- **The loop is drawn once, as `#loop` in `<defs>`, and `<use>`d three times.**
  Keep it that way. The rows being *provably* identical is the argument; the
  eye lines them up and the only difference left is what falls out the end.
- **The big arrow carries no label, on purpose.** It used to say "one
  probabilistic pass" above and "woven here" below; stacked three deep that was
  six lines of repeated text. Both are now spoken, not drawn. Anything added to
  `#loop` costs 3×, so the bar for putting text in there is high.
- **The three documents differ in MOTIF, not in proportion:** `#doc` (stripes,
  run 1), `#docDots` (run 2), `#docBlocks` (run 3). Same frame, same two colors,
  unmistakably different weave. Do not "unify" them back into three stripe
  patterns — legibility at distance is the whole reason they exist. The rows are
  **unlabelled**: no "run 1 / run 2 / run 3". Three documents falling out of one
  identical loop already says it, and the numbers only invited reading the stack
  as progress.
- **A known imperfection, considered and kept.** "Format as little dots" is a bit
  odd — arguably the format *is* the box, and only the content should vary. But
  an agent re-draws the wording too, not just the layout, so both really do move
  between runs. Holding one motif fixed would quietly claim otherwise. If this
  ever gets revisited, that's the trade being made.
- **Nothing points from one document to the next.** The only route between rows
  is the dashed *review & re-prompt* connector, and it lands on `me`, never on
  the document. Run 2 is not an edit of run 1; run 1 is discarded and the whole
  thing rewoven. That's the eight-rounds story, and it's what the old
  replace-in-place build was carrying. If you ever redraw this, **do not draw an
  arrow from run 1 to run 2** — that turns the figure into an argument for
  iteration converging, which is the opposite claim.
- **The lift is CSS, not a reveal effect.** The row-1 group is
  `fragment custom lift`; reveal's `.fragment:not(.custom)` rule leaves it
  visible at rest and just toggles `.visible`, and `custom.css` parks it 150
  user units low until then. Degrades safely: without that rule the row renders
  at its final position and simply doesn't move.
- **Nothing is captioned at the bottom.** A summary line ("same prompt, same
  model — a different document every time") lived there and was cut as implied.
  The stack is the caption.
- **Both arrows in `#loop` are identical** — `stroke-width="2.5"`, a 50-unit run,
  a 4-unit gap before whatever they land on. me→agent and agent→document are the
  same kind of step and should not be weighted differently; the second one used
  to be a 274-unit, 6-wide slab. That shortening is what pulled the document in
  to x=621 and left the row centred with 211 units of margin either side.

**Slide 2 ends in ONE output, and it is byte-identical to slide 1's run 1.**
`#docOut` is a hand-kept copy of `#doc` — **if you edit one, edit both.** The
claim is *not* "this makes a better document"; it's that the weaving moved
somewhere you can reach. Losing that identity silently turns the figure into an
argument for determinism, which is the wrong takeaway (a better model doesn't fix
entanglement). It carries **no caption** — "same input, same document — every
time" was there and was cut; the identical bar is the caption. "woven here" is
gone from both slides too.

- **The `.qmd` box is a NEUTRAL container — black stroke, never blue.** That is
  load-bearing. It holds a blue `yaml` block and an amber `content` block, each
  in its own place. Painting the container blue would say "format contains
  content"; painting it black says "a file contains both," which is what a
  `.qmd` is. This is the **only** box in the deck where the two colours nest.
- **The blue IS the YAML, and naming it is worth the ink.** It turns "format"
  into something the room can point at, and it is precisely what Act 6's *change
  one word* changes — the figure sets up its own callback four acts later. If it
  ever needs to be more concrete, `format: pdf` in the band beats the word
  `yaml`; don't annotate further than that. **The file is not meant to be read**,
  only to show that each half has a place.
- **The `.qmd` and the output bar carry the same two colours on purpose.** In the
  file they sit in labelled blocks; in the bar they interleave with no boundary.
  That contrast is the whole address argument, so the two must stay on screen
  together — don't move the output off this slide.
- **`data` is amber, lives outside, and feeds the `.qmd` — not render.** Data *is*
  content; what differs is the kind of address (a row, not a line number), which
  is why it doesn't get a colour of its own. Routing it into the `.qmd` is both
  literally true (a chunk reads it at render) and safe *because the container is
  neutral* — an earlier version fed it straight into render, on the reasoning
  that flowing amber into a blue box collapses two addresses into one. That
  objection died with the blue box; if the container ever goes back to blue,
  the routing has to go back too.
- **Nothing points at `data`** — not the agent, not the green arrow. Data comes
  from the world. Resist adding an arrow; the empty input is the point.
- **One green arrow, landing square on the `.qmd`'s bottom edge.** It lands on
  the file, not on either block, because both halves inside it are yours to edit.
  There were two; the second pointed at `data`, which reversed the tier-2 story
  (you don't hand-type exact values, you recompute them). An even earlier version
  ended *beside* the `data` box, pointing up past it at nothing. It enters at
  x=418 — left of the `data` box, which stays **centred on the `.qmd` at x=493**.
  Arrows get out of each other's way; boxes don't go off-axis to make room.
- **Every arrow in the figure is `stroke-width="2.5"`.** `markerUnits` is
  `strokeWidth`, so a fatter line silently means a fatter head: the green arrow
  at 3 had a head running 16.5 units back from the tip, which overlapped its own
  corner. If a line ever needs a different weight, check that the straight run
  before the tip is longer than 5.5 × stroke-width.

**Click 2 on slide 2: the content changes and the format doesn't.** The amber
`content` block in the `.qmd` and every amber band in the output bar turn green
together, in place; the blue bands are byte-identical and **do not move**. That
stillness is the argument — a regenerated document can never promise it. Green
because green has meant *your direct action* since the arrow one click earlier,
so the green bands read as exactly the bits your hand reached.

- `#docOutEdited` is `#docOut` with every `#C0820F` → `#38B44A` and **nothing
  else changed** — same rects, same widths, same order. Edit one, edit both, or
  the click stops meaning "only the content changed." (Generate it, don't
  hand-copy: `body.replace('#C0820F','#38B44A')`.)
- The at-rest bar is still byte-identical to slide 1's `#doc`. The rule covers
  the document *before* the click; the green state is a third thing.
- Mechanism is the swap-in-place pattern: `fragment fade-out` at index 2 for the
  amber version, plain `fragment` at index 2 for the green one, same transform.

## The three-sheet payoff (Act 2, immediately after the figure)

**"Same `format`. No drift."** — three lexis columns, each a `.qmd` box over the
real sheet it produces: pokemon, minecraft, mario. It cashes the abstraction out
in the actual artifacts and answers the Act 1 cold open, and the spine sentence
lands on the slide right after it.

It is **deliberately the same shape as figure slide 1** — three variants of one
identical thing — with the meaning inverted. There, one unchanged input gave
three different documents. Here, three changed inputs give three documents that
differ only where they were changed. Keep that rhyme.

- **What carries it is what doesn't vary.** Same `.qmd` box as the figure, same
  190×124, and the blue `yaml` band byte-identical in all three columns. Only
  the content block changes: one word, one colour. The three SVGs are verified
  identical apart from that — keep them that way, it's the argument.
- **Colours are amber / purple / red — NOT green.** Green means *your direct
  action* and was on screen one slide earlier as the content you had just
  edited; a green block here reads as "this is the edited one". Thematic
  colours (pokemon amber, minecraft green, mario red) are charming and cost
  exactly that.
- **No `render` label under the arrows** — three of them is three repetitions of
  a word the previous slide just taught. Same rule as `#loop`: anything inside a
  repeated unit costs 3×.
- These three SVGs use **no ids and no markers** — arrowheads are explicit
  triangles — so they add nothing to the document-wide id namespace. Keep it
  that way if you copy the pattern.

Mechanics: pure inline SVG in a ```` ```{=html} ```` block + reveal fragments — no
anime.js, no CDN, nothing to vendor. Slide 1 is `viewBox="0 0 1240 585"` (three
rows, centerlines at y = 175 / 340 / 505), slide 2 is `viewBox="0 0 1240 470"`,
and each carries **its own `<defs>`**; they deliberately do *not* share one `<use>`
across slides, because reveal puts non-current slides in `display:none` and
cross-slide `<use>` resolution is unreliable there. SVG ids are unique across the
whole document (`ahDark`/`ahDark2` etc.) — keep them that way. **Both slides
share the 1240-unit width on purpose**: same viewBox width means both render at
the same scale, so a box on slide 2 is physically the same size as the matching
box on slide 1. Don't shrink slide 1's width to close up its margins — that
silently breaks the mirroring.

**All five arrowhead markers use `refX="5.5"`, not `7`.** `markerUnits` defaults
to `strokeWidth`, so the head scales with the line. Putting refX on the tip (7)
parks the point exactly at the path end, and near that point the triangle is
narrower than the stroke is thick — so the line's butt-cap pokes out through the
tip. Backing refX off by 1.5 marker units slides the head forward until the
stroke ends where the triangle is already wider than it. Consequence: **the
visible tip lands 1.5 × stroke-width beyond the path end**, so path endpoints are
written with that overhang already subtracted (e.g. the connectors stop at
y=301/466 to land ~3 units above the `me` boxes at y=308/473). If you ever change
a stroke width, re-check the arrow's landing gap.

**Not yet visually vetted.** Coordinates are hand-computed; bounding boxes were
checked on paper but never rendered. Likeliest cosmetic fixes: on slide 1, the
`review & re-prompt` labels sit ~22px under their connector lines; on slide 2,
the `writes` label wedged between the agent and `.qmd` boxes (~50px clearance),
and whether white monospace on the amber `content` block has enough contrast —
`#C0820F` is dark enough that it should, but it is the one colour pairing here
that has never been looked at. Slide 1 is tall
(585 units) and its aspect is wider than 16:9, so **width** is what binds, not
`max-height:80vh` — to make its type bigger, raise the font sizes; narrowing the
viewBox would work too but is ruled out by the shared-width rule above, and
changing the height alone does nothing.

**Known asymmetry, not yet resolved:** slide 1's `me`/`LLM agent` boxes are
110/180 wide and slide 2's are 96/156, at different x. The pair is *supposed* to
read as one picture with one variable changed, so this is worth a pass — but
slide 1's row is centred and slide 2's chain is genuinely longer (it has `.qmd`
and `data` in the middle), so they can't be both centred and x-aligned. Pick one
before fiddling.

## Styling

`index.qmd` uses the **`lexis-revealjs` format extension**
(`_extensions/lexis/`, from `jhelvy/quarto-lexis`) — the packaged port of John's
xaringan "lexis" theme. **Authoring paradigm differs from stock Quarto reveal:**

- **`---` starts every slide.** `#`/`##`/`###` are text sizes *within* a slide,
  never slide breaks (`slide-level: 0`).
- **Slide modifiers are shortcodes:** `{{< inverse >}}` `{{< center >}}`
  `{{< middle >}}` `{{< bg-color >}}` `{{< bg-image >}}` `{{< no-slide-number >}}`.
  Statement/divider slides are the inverse+center+middle stack + a `#` heading.
- **Columns are consecutive `::: {.col}` divs**, no outer wrapper. Uneven splits
  via `width="55%"` on one column. (The old float classes `.leftcol`/`.rightcol`
  are gone — lexis doesn't ship them.)
- **No auto title slide** — it's hand-authored as the first `---` slide using
  `{{< meta title >}}` etc.
- **Utility classes** come from the extension: colors (`.blue .red .green
  .darkgreen .orange .purple .gray` …), sizes (`.small .large
  `.font10`–`.font200`), `.fancy`, `.fira`, image helpers (`.border .circle
  .polaroid .thumbnail`), `::: {.panel-tabset}`.
- **Full authoring reference: the `/lexis` skill.** Use it before editing the
  deck's structure. `/lexis-clean` audits an existing deck.

One local stylesheet, `custom.css`, loaded via the **nested** format key:

```yaml
format:
  lexis-revealjs:
    css: custom.css
```

That nesting is load-bearing. `format: lexis-revealjs` as a bare scalar has no
place to hang `css:`, and for a long time the key was simply absent — so
`custom.css` never loaded and every rule in it was silently dead. If a class
defined there "doesn't work," **check this YAML first**, before touching CSS.

`custom.css` holds only what lexis does not ship, and nothing else belongs there:

- `.amber` — the talk's "content" color (`#C0820F`), matching the amber in the
  entanglement figure so deck and figure stay consistent.
- `.amberborder` / `.blueborder` — colored image borders following lexis's own
  wrapper-div pattern (`.treatment img`), so they go on a **wrapping div**, not in
  the image's attribute block: `::: {.col .blueborder}`. Used on the "I want
  *this* layout, with *these* sentences" slide to tie each colored word to an
  image. Same two hexes as the figure.

`custom.scss` is still on disk but is now **dead** — it was the pre-extension
hand-port, and its last consumer was the standalone figure document, which no
longer exists. No `.qmd` in the repo loads it; the only remaining references are
prose lines in `README.md` and this file. Safe to delete whenever John wants to.

## Hard rules

- **Never run `quarto render`** or any render command. Make changes, report done,
  let John render in his own terminal.
- **Never run `git` commands.** John commits/pushes himself.
- Simplicity first; surgical changes; match existing style.
- Paraphrase external sources; no long quotes.
- Section dividers are **statements, not labels.** Never put "Act 3" or a category
  name on a slide — that reintroduces the taxonomy problem.

## Open / to do

- **Visually vet the entanglement figure.** It's written and in the deck, but has
  never been rendered — coordinates are hand-computed. See the figure section for
  the two likeliest collisions. Check both slides' fragment steps actually build
  the way they're meant to.
- **Produce remaining demo assets.** The handwriting-sheet images exist; these
  slots are still marked with `> **[BRACKETED]**` blockquote placeholders in
  `index.qmd`:
  - silent dashboard screen recording (~75s) for Act 4
  - a screenshot of the MapLibre map on `market-concentration.qmd`
  - the live inline interactive chart for Act 5
  - the multi-turn token chart for Act 3 (see below — needs real numbers)
- **Refresh `README.md`** — it still names `custom.scss` as the theme and doesn't
  mention the lexis extension at all.
- **Optional "what bit me" slide** — only if John supplies real, lived pitfalls
  from building the dashboard. Never fabricate them.
- **Multi-turn token data** — Act 3's SECOND slide ("And that's just the first
  turn") is a placeholder. The single-shot table IS in the deck already (Word
  8097→1121, HTML 4046→1022, PDF 1992→1123, Markdown 1267→1282, from the blog
  post). The multi-turn/agentic cost-growth section is NOT yet published on the
  blog. Needs John's numbers. Never invent them. Frame it as the *measured*
  version of the Act 1 anecdote (one edit → full regeneration → full price), not a
  second benchmark.
- **Verify hosting claim.** Slides say GitHub Pages (matching John's framing), but
  the dashboard's `tech-stack.qmd` says Netlify while its `claude.md` says GitHub
  Pages. Confirm what actually serves vehicletrends.us before presenting.
- Optional: email the three co-speakers to compare notes (Blake's talk is also
  AI-adjacent — his angle is data made *consumable by* AI, this one is AI
  *producing* artifacts; complementary, but check the setup slides don't collide).
