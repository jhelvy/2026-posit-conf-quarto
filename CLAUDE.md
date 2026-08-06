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
| 2:30–5:30 | **2. The move** | Entanglement = no address. The figure (2 slides). The payoff slide. Spine sentence (1/3). *Architect, don't prompt* |
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

**Figure source.**

- `plots.R` — regenerates every image in `images/` that is a *plot*. Right now
  that is only `images/fig-tokens.png`. Run it with `Rscript plots.R`; it writes
  straight into `images/`. Everything else in `images/` is a screenshot, a GIF,
  or a PDF export and does **not** come from here.
- `data/token_results.csv` — a verbatim copy of the token-efficiency post's data
  file (`jhelvy.com/blog/2026-05-12-quarto-optimal-claude-output/data/`), so the
  numbers on the Act 3 slide and the numbers in the post are the same numbers.
  **The deck is now the same shape as its own thesis:** the figure has an
  address, and the values are recomputed rather than typed. If the numbers ever
  change, edit the CSV and re-run — never hand-edit the PNG.

**`fig-tokens` departs from the blog version in four ways, all deliberate:**

1. **Font is Fira Sans Condensed** (the lexis deck font), not Roboto Condensed.
2. **Colors are minou** — teal = Quarto, red = direct format. See Palette.
3. **The per-dot token counts are gone.** The axis already gives the magnitudes.
4. **A bold multiplier sits to the right of each direct-format dot** — 1×, 1.8×,
   4×, 7.2× — computed from the CSV, never typed. It is the only annotation left,
   and it is the sentence John says out loud. The `.0` is stripped so these read
   "4×" not "4.0×", and the x-axis right expansion (`0.14`) exists to hold them —
   shrink it and the `7.2×` clips.

`dpi = 192` reproduces knitr's default (96 × `fig-retina` 2), which is why the
output is 1920×960 — the same pixel dimensions as the post's.

**The plot lands on an `{{< inverse >}}` slide** and has a white background, so
it currently reads as a pasted-in exhibit on a dark slide. Not yet decided
whether to leave it or give it a dark panel.

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
| `handwriting-good-{pokemon,minecraft}.png` | Act 2 payoff — the two-sheet slide |
| `handwriting-good-mario.png` | **unreferenced** since the payoff went from 3 columns to 2 |
| `handwriting-practice-minecraft.pdf` | **png is gone**; only the pdf survives, nothing references it |
| `vehicletrends.gif` | the teaser slide right after the title |
| `fig-tokens.png` | Act 3, token cost — **generated by `plots.R`**, don't hand-edit |
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

## The palette

**Every color in the talk comes from `ltc::ltc("minou")`** — slides, the
entanglement figure, and the plots in `plots.R` are one palette. `ltc` is
John's own color package; `minou` is one of its 31 built-ins.

| Hex | Name | Role |
|---|---|---|
| `#edae49` | yellow | **content / data** |
| `#00798c` | teal | **format / structure** |
| `#d1495b` | red | **content that changed**; also Shiny and raw HTML |
| `#2e4057` | navy | **ink**: every stroke, arrowhead and label in the figure |
| `#852f88` | purple | **your direct action** — *not minou, see below* |
| `#66a182` | green | **retired** — nothing uses it |
| `#8d96a3` | grey | unused |

**Purple is the one deliberate outsider.** It comes from `ltc("hat")`, and it is
the only colour in the deck that isn't minou. It earns the exception because it
has one job — be the thing your eye goes to — and minou has nothing left that
can do it. Hue 306 is the one region minou leaves empty (nearest neighbour 59°
away), at chroma 62 and 7.6:1 on white.

It replaced a green (`#4A6D5A`) John found too easy to miss, and the reason is
measurable and worth remembering: **that green sat at chroma 20 against navy's
21.** Same saturation, similar darkness, so it read as just another structural
line instead of the one line that is *you*. When picking an accent, **chroma is
the axis that matters, not hue.**

**Green is now retired.** It was "your direct action" (now purple) and minecraft
on the payoff slide (now red). `.green` still resolves but nothing uses it — if
you reach for it, check you don't mean purple or red.

**Fill vs. ink — the one rule that isn't obvious.** minou's yellow and green are
light (lightness 75 and 62). They work as **fills** with dark text on them, but
as text or a thin stroke on a light slide they measure 1.6:1 and 2.5:1 —
invisible from the back of a room. Each therefore has a darker **ink** variant at
the same hue (drift < 0.5°, so both genuinely read as "the yellow one"), used
wherever the color has to be a line or a letter:

| | fill | ink |
|---|---|---|
| yellow | `#edae49` | `#A77400` |
| green | `#66a182` | `#4A6D5A` | *(both retired — nothing uses either)* |

Teal and red are dark enough to serve as both and have no ink variant.
Consequence inside the figure, and it looks inconsistent until you know why:
**text on a teal band is white; text on a yellow band is navy; text on red is
white.**
That is forced by legibility, not taste — don't "fix" it.

**Red is the one fill that takes either** (4.4:1 white, 4.3:1 navy), so on red
the text colour is an editorial choice rather than a legibility one, and the
deck uses it both ways on purpose:

- **white**, everywhere red means *changed content*: the figure's click-3
  `content` block, the heading chip that recolours with it, and the payoff
  slide's minecraft column. Flipping the text *and* the fill makes it read as a
  **state change**, not a recolour.
- The rule is therefore simple now that mario is gone: **red always takes white
  in this deck.**

**Prefer a chip to ink where the color is being *taught*.** The split above is a
compromise, and it costs the most on the two slides before the figure, whose
whole job is to teach the vocabulary the figure then uses — teaching the ink
yellow and then showing the fill yellow undercuts them. So those words are
**chips**: `[**these**]{.contentchip}` / `[**this**]{.formatchip}`, an inline
block in the fill color with the same text color the figure's bands use. The
word stops being *the same hue as* the content band and becomes *the same object
as* it. Longer phrases elsewhere (`[**The agent never touched:**]{.amber}`) stay
plain colored text — a chip round a whole clause reads as a highlighter, not a
swatch.

**Both figure headings are now lexis lines, not SVG text** — see the figure
section. **The two figure SVGs now contain no ink yellow at all.** The `data`
box was the last holdout; it is now drawn exactly like the `content` block —
solid `#edae49`, navy text — with a navy arrow like every other structural
connector. So inside the figure the rule is absolute: **yellow and green appear
only as fills, never as a line or a letter.** The ink variants survive purely as
*text* colours on slides (`.amber`, `.green`), where there is no block to sit
on. What that cost: the arrow into the `.qmd` no longer reads as "content
flowing in" — the yellow block at one end and the yellow band at the other carry
that instead, and a third yellow on screen bought nothing.

**Why minou and not something prettier.** John first asked for `paloma`. Paloma
is a five-color pastel set with **no blue and no dark color**, spanning hues
2°–154°. Once yellow / green / red were reserved for pokemon / minecraft / mario,
the only candidates left for *format* were khaki `#C8C8A9` and peach `#f7bf95` —
both within 25° of the content yellow and 1.04:1 against each other. Content vs.
format is the load-bearing pair in the whole deck, so that was fatal. minou was
chosen because it is the only ltc palette that covers all six roles at once:
content and format land **163° apart** and stay distinct under red-green
colorblindness (`#D4C04C` vs `#5B698C`). If the palette is ever revisited, that
is the test to re-run — not "does it look nice."

**Where the hexes actually live.** `custom.css` (semantic classes + the header
comment that restates all of this), the five inline SVGs in `index.qmd`, and
`plots.R`. There is no shared variable across those three — a palette change is a
three-file find-and-replace, so check all three.

**lexis's own color utilities are overridden.** `.blue` / `.red` / `.green` ship
as `#007bff` / `#E74A2F` / `#38B44A`; `custom.css` repoints them at minou so a
`[word]{.blue}` on a slide is the same teal as the format band in the figure.
Same specificity as lexis's rules, and `custom.css` loads after the theme, so
they win. `.amber` is ours and is the **ink** yellow, because it is only ever
text.

## The entanglement figure

**Settled: the figure is IN, and it is TWO slides**, both inline SVG living
directly in `index.qmd` (Act 2, right after "Where is the sentence?"). Neither is
`{{< inverse >}}` — the SVG uses white fills and near-black strokes and needs a
light slide.

```
SLIDE 1 —  content/data ENTANGLED WITH structure/format   (one loop, stacked 3×)
   [ me ] ──▶ [ agent ] ═══▶  (▓▒▓▒▒▓)          stripes in an OVAL
      ▲          (dashed)
      └──── review & re-prompt ──┐
   [ me ] ──▶ [ agent ] ═══▶  (∴∵∴∵∴)           dots
      ▲                                           same loop,
      └──── review & re-prompt ──┐                different weave
   [ me ] ──▶ [ agent ] ═══▶  (▪▫▪▫▫)           blocks

SLIDE 2 —  Quarto DISENTANGLES Content and Format
   at rest — identical to slide 1's row 1, in the same place on screen:
   [ me ] ──▶ [ agent ] ═══▶  (▓▒▓▒▒▓)

   click 1 — the chain opens ±140 and the .qmd drops into the gap:
                                     ┌ .qmd ──────┐
   [ me ] ──▶ [ agent ] ──writes───▶ │ ▒▒ yaml ▒▒ │ ──render──▶ (▓▒▓▒▒▓)
      │          (dashed)            │ ▓▓content▓▓│
      └──── you edit directly ─────▶ └─────▲──────┘   click 2: PURPLE arrow
                    (click 2)         [▓ data ▓]      click 3: yellow→RED,
                                       same fill as            teal fixed
                                       `content`
```

**Both headings are ordinary lexis `#` lines ABOVE their SVG, and they are the
whole legend.**

```
# [Content]{.contentchip} entangled with [Format]{.formatchip}
# Quarto disentangles [Content]{.contentchip} and [Format]{.formatchip}
```

Slide 2's is slide 1's sentence with two words inserted — that echo is the
point, so change them together or not at all.

They **used to be SVG `<tspan>`s** at `font-size="50"`, and moving them out is
what lets them use the same chips the setup slides teach: a `<tspan>` can't have
a background, so inside the SVG the words had to be the darker *ink* yellow
while the bands beside them were the *fill* yellow — the legend taught one
colour and the figure showed another. As markup the browser sizes the chips and
no text metrics are hand-computed. Both are `#`, and they must STAY the same
level as each other: the two slides are registered (below), and a different
heading height on one of them would break that.

**The viewBox top crop moves with those headings** (below): each `min-y`
reclaims exactly the space its old `<text>` held, so if a heading ever goes back
inside its SVG the crop has to be undone with it.

**THE TWO SLIDES ARE REGISTERED, and that is load-bearing.** Slide 2 at rest is
*byte-for-byte slide 1's row 1* — same boxes, same widths, same coordinates
(me x=285, agent x=485, artifact x=755, row centred on y=175), differing only in
the per-slide marker id. **Both slides now carry the identical viewBox,
`0 77 1240 553`**, so the registration is exact by construction rather than by
arithmetic: same box, same row y, and since both are width-bound at 1240 and
vertically centred on the slide (`{{< middle >}}`), the row lands on the same
pixels. Advancing from slide 1 to slide 2 therefore changes **nothing at all**
until you click — that stillness is the setup, and it is what earns the "one
picture with one variable changed" claim. Slide 2's content ends at y≈351, so
it carries ~280 units of dead canvas below the figure purely to hold the
registration; it is invisible and it is the price. **Anything that changes
either viewBox, either heading level, or that row's geometry breaks the
registration — recompute both.**

Why 553 and not more: the lexis slide is **1600×900** with `padding: 45px 90px
60px`, so the usable box is 1420×795, and the `#` heading eats ~100px of it.
At viewBox width 1240 the figure renders 1420 px wide and 553/1240 × 1420 ≈
**633 px** tall, which with the heading is ~735 of the 795 available. That
~60px is the entire remaining slack — **height is now the binding constraint on
slide 1, not width**, and it is why the artifact could get narrower but not
appreciably taller.

The color vocabulary is taught by the two slides *before* the figure and never
re-explained inside it:

1. **concrete** — "I want [*these*]{content chip} sentences with [*this*]{format
   chip} layout", over the two handwriting sheets in matching colored borders;
2. **named** — "If you ask AI for the *artifact*, the [Content]{content chip} is
   entangled with the [Format]{format chip}";
3. **the figure**, carrying that same sentence across its top in the same chips.

Don't reintroduce a swatch legend. There was one; at 17px it was unreadable from
the back, and it duplicated in miniature what step 2 already says at full size.

Design rules, in force:

- **THE ARTIFACT IS AN OVAL, and the shape is doing work.** Three shapes, three
  kinds of thing: **rounded rects are actors** (`me`, the agent), **a rect is a
  file** (the `.qmd`), and the artifact is **neither**. In flowchart grammar an
  oval is the terminator — the end of the line — which is exactly what a
  rendered artifact is, and it also draws the thesis: a shape with no corners
  and no edges has nothing to index against, so *you cannot point into it*.
  **Hold this shape constant across both figure slides**; it is
  `200 × 116`, an `<ellipse cx=100 cy=58 rx=100 ry=58>`, drawn 1:1 in parent
  units (**no `scale()` on the `<use>` any more**). It replaced a 240×64 def at
  `scale(1.7)` — 408×109, nearly four times wider than tall, which John read as
  "a pretty long and big rectangle" rather than as a thing. Same height, half
  the width.
- **Never draw the OUTPUT as content nested inside a format box.** Containment
  implies the two are already separate and in their own places, which is the
  visual opposite of entanglement. The artifact is always **irregular stripes,
  content and format interleaved, no boundaries** — now clipped to the oval via
  a `<clipPath>`, which leaves thin crescents at each end. That is correct:
  they are stripes, not objects. (Scope matters: nesting inside the **`.qmd`**
  on slide 2 is not a violation, it is the claim — see below. The rule is about
  the artifact, not the source.)
- **Color vocabulary (never break it):** yellow = **content**, teal =
  **format/structure**, purple = **human's direct action**, red = **content that
  changed**. Purple and red appear on slide 2 only. Exact hexes and the fill/ink split
  live in **the Palette section below** — read it before touching a color.
- **The agent box is identical and dashed on both slides.** Dashed = stochastic.
  It is deliberately *unchanged* between them: the agent did not get better, the
  thing it writes did. Don't "improve" the agent on slide 2.
- **Slide 2 at rest *is* slide 1's row 1** — not merely a mirror of it. See the
  registration note above; this replaces an older slide 2 that had its own
  smaller boxes (me 96 wide, agent 156) at its own coordinates, and a
  `prompt once` label. Both are gone: at rest, slide 2 must claim nothing slide
  1 didn't.
- Its job in Act 2 is **generalization, not explanation** — the handwriting sheet
  already taught the idea. That justifies a simple picture.

**Slide 1 shows variance by stacking the same loop three times.** (This replaces
an earlier swap-in-place build, where three documents shared one slot and
replaced each other. It was too subtle to read from the back of the room — the
only thing that changed was stripe widths inside a small box.) Now: at rest, one
loop, **already in the top third at its final y=175**. Click 1 adds run 2
beneath it; click 2 adds run 3.

- **The loop is drawn once, as `#loop` in `<defs>`, and `<use>`d three times.**
  Keep it that way. The rows being *provably* identical is the argument; the
  eye lines them up and the only difference left is what falls out the end.
- **The big arrow carries no label, on purpose.** It used to say "one
  probabilistic pass" above and "woven here" below; stacked three deep that was
  six lines of repeated text. Both are now spoken, not drawn. Anything added to
  `#loop` costs 3×, so the bar for putting text in there is high.
- **The three documents differ in MOTIF, not in proportion:** `#doc` (stripes,
  run 1), `#docDots` (run 2), `#docBlocks` (run 3). Same oval, same two colors,
  unmistakably different weave. Do not "unify" them back into three stripe
  patterns — legibility at distance is the whole reason they exist. Only the
  stripes are clipped; **every dot and block is placed to sit wholly inside the
  oval** so nothing is sliced in half at the rim (a clipped half-dot reads as a
  rendering bug, a clipped stripe doesn't). `r=10` and side 14–18 keep them the
  physical size they had at `scale(1.7)`. The rows are
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
- **Nothing on this slide moves — run 1 is static.** ❌ **Reversed decision, do
  not reintroduce:** run 1 used to be `fragment custom lift`, parked low by a
  `.lift` rule in `custom.css` so it read as centred on its own, then sliding up
  to y=175 on click 1 to make room for run 2. John cut it — a row sliding up is
  a motion the room has to parse *before* the point lands, and the at-rest
  composition was never the argument. Run 1 now renders at y=175 from the moment
  the slide appears and the other two arrive underneath it. Click count is
  unchanged (2). The CSS is gone; `custom.css` keeps the rule in a comment with
  the arithmetic, in case it is ever wanted back.
- **Nothing is captioned at the bottom.** A summary line ("same prompt, same
  model — a different document every time") lived there and was cut as implied.
  The stack is the caption.
- **Both arrows in `#loop` are identical** — `stroke-width="2.5"`, an **80-unit**
  run, an 8-unit gap before whatever they land on. me→agent and agent→artifact
  are the same kind of step and should not be weighted differently; the second
  one was once a 274-unit, 6-wide slab. They were 50 until the artifact
  narrowed: the oval gave back 208 units of width, and 30 of that went into each
  arrow so the chain still spans the slide. **80 is now the only arrow length in
  the whole figure** — slide 1's two and slide 2's three — which retires the old
  50-vs-80 split. Row: me x=285, agent x=485, artifact x=755, ending at 955,
  centred with 285 units of margin either side.
- **The rows are 186 apart** (was 165), i.e. **70 units of clear air** between
  one artifact and the next, against 56 before. John's read was that "the lines
  feel a little cramped," and the measurable version is the `review &
  re-prompt` label: it used to clear the next row's document by **2 units** and
  now clears it by **15**. The oval is 7 units taller than the bar it replaced,
  so all of the extra spacing came out of the height budget above — see the
  1600×900 arithmetic in the registration note before adding any more.

**Slide 2 ends in ONE output, and it is byte-identical to slide 1's run 1.**
`#docOut` is a hand-kept copy of `#doc` — **if you edit one, edit both.** The
claim is *not* "this makes a better document"; it's that the weaving moved
somewhere you can reach. Losing that identity silently turns the figure into an
argument for determinism, which is the wrong takeaway (a better model doesn't fix
entanglement). It carries **no caption** — "same input, same document — every
time" was there and was cut; the identical bar is the caption. "woven here" is
gone from both slides too.

- **The `.qmd` box is a NEUTRAL container — navy stroke, never teal.** That is
  load-bearing. It holds a teal `yaml` block and a yellow `content` block, each
  in its own place. Painting the container teal would say "format contains
  content"; painting it black says "a file contains both," which is what a
  `.qmd` is. This is the **only** box in the deck where the two colours nest.
- **The teal IS the YAML, and naming it is worth the ink.** It turns "format"
  into something the room can point at, and it is precisely what Act 6's *change
  one word* changes — the figure sets up its own callback four acts later. If it
  ever needs to be more concrete, `format: pdf` in the band beats the word
  `yaml`; don't annotate further than that. **The file is not meant to be read**,
  only to show that each half has a place.
- **The `.qmd` and the artifact carry the same two colours on purpose.** In the
  file they sit in labelled blocks; in the oval they interleave with no
  boundary. That contrast is the whole address argument, so the two must stay on
  screen together — don't move the artifact off this slide. The **shapes** say
  it a second time now: the file is a rect you can point into, the artifact is
  an oval you can't.
- **`data` is yellow, lives outside, and feeds the `.qmd` — not render.** Data *is*
  content; what differs is the kind of address (a row, not a line number), which
  is why it doesn't get a colour of its own. Routing it into the `.qmd` is both
  literally true (a chunk reads it at render) and safe *because the container is
  neutral* — an earlier version fed it straight into render, on the reasoning
  that flowing yellow into a teal box collapses two addresses into one. That
  objection died with the teal box; if the container ever goes back to teal,
  the routing has to go back too.
- **Nothing points at `data`** — not the agent, not the purple arrow. Data comes
  from the world. Resist adding an arrow; the empty input is the point.
- **One purple arrow, landing square on the `.qmd`'s bottom edge.** It lands on
  the file, not on either block, because both halves inside it are yours to edit.
  There were two; the second pointed at `data`, which reversed the tier-2 story
  (you don't hand-type exact values, you recompute them). An even earlier version
  ended *beside* the `data` box, pointing up past it at nothing. It enters at
  x=635 — inside the `.qmd`'s left edge (615) but left of the `data` box, which
  stays **centred on the `.qmd` at x=710**.
  Arrows get out of each other's way; boxes don't go off-axis to make room.
- **Every arrow in the figure is `stroke-width="2.5"`.** `markerUnits` is
  `strokeWidth`, so a fatter line silently means a fatter head: the edit arrow
  at 3 had a head running 16.5 units back from the tip, which overlapped its own
  corner. If a line ever needs a different weight, check that the straight run
  before the tip is longer than 5.5 × stroke-width.

**Slide 2 builds in three clicks:**

| Click | What happens |
|---|---|
| *(rest)* | slide 1's row 1, exactly and in the same place |
| **1** | the chain opens ±140 and the `.qmd` + `data` fade into the gap |
| **2** | the purple *you edit directly* arrow |
| **3** | the content turns **red**; the format does not move |

**Click 1 is the one the slide is built around.** Inserting the `.qmd` makes the
chain 280 units longer, so it grows **symmetrically** — `me`+agent glide 140
left, the artifact glides 140 right — and the row stays centred. Two CSS rules
(`.openleft` / `.openright` on `fragment custom` groups) do the gliding; **they
are not optional**, unlike the old `.lift`, because without them the boxes stay
put and the `.qmd` lands on top of the artifact. 140 = (950 − 670) / 2. Opened,
the chain runs me 145 · agent 345 · `.qmd` 615 · artifact 895–1095, with 145
units of margin either side and a uniform 90-unit gap at every step.

**Every arrow in the figure is 80 units** — there is no longer a special case
around the `.qmd`. It used to be 80 there and 50 everywhere else, so that
`writes` and `render` weren't wedged against the boxes; when the artifact
narrowed, slide 1's arrows went to 80 too and the split retired. `writes` and
`render` are consequently the **same font size** now (20). General rule:
**shift = 75 + L**, and usefully the `.qmd` lands at x=615 *whatever* L is, so
the data box, its arrow and the edit arrow's landing point never have to be
recomputed when the arrows change. The direct agent→artifact arrow is nested
*inside* `.openleft` so it travels with the agent while it fades — the one line
that says "entangled" leaves as the file that fixes it arrives.

**Click 3: the content changes and the format doesn't.** The yellow `content`
block in the `.qmd` and every yellow stripe in the artifact turn **red**
together, in place; the teal stripes are byte-identical and **do not move**.
That stillness is the argument — a regenerated document can never promise it.

Red is `#d1495b`, and the payoff slide two slides later uses **that exact red,
white text and all**, for the minecraft column. So this click and that slide are
the same event twice: once abstract, once in real paper.

**The heading recolours with it.** The word `Content` in the `#` line above the
figure is a `.contentchip .fragment .custom .turnsred` at index 3, so it turns
red at the same moment the block does — legend and figure never disagree. It is
a CSS colour toggle rather than a second heading because reveal hides fragments
with `visibility:hidden`, which still occupies layout: two stacked headings
would have reserved space for both.

**The split with the arrow is deliberate.** The `you edit directly` arrow one
click earlier is **purple**; the result is red. Purple is the *action*, red is
the *changed content*. There is no colour link from hand to band and there
doesn't need to be — the arrow is labelled.

- `#docOutEdited` is `#docOut` with every `#edae49` → `#d1495b` and **nothing
  else changed** — same rects, same widths, same order. Edit one, edit both, or
  the click stops meaning "only the content changed." (Generate it, don't
  hand-copy: `body.replace('#edae49','#d1495b')`.)
- The at-rest oval is still byte-identical to slide 1's `#doc` (modulo the
  per-slide clip id). The rule covers the artifact *before* the click; the red
  state is a third thing.
- **Mechanism is now an overlay, not a swap.** The red versions are drawn
  *after* the yellow ones with identical geometry, so they simply paint over.
  This replaced a `fade-out` + `fragment` pair, which stopped working once the
  `.qmd` itself became a fragment: a `fade-out` is visible *at rest*, so the
  amber block would have floated on screen before its own box existed.

## The payoff slide (Act 2, immediately after the figure)

**"Same `format`. No drift."** — **two** lexis columns, each a `.qmd` box over
the real sheet it produces: pokemon and minecraft. It cashes the abstraction out
in the actual artifacts and answers the Act 1 cold open, and the spine sentence
lands on the slide right after it.

**It is figure slide 2's click, frozen.** There, `content` went yellow → red
inside a `.qmd` box and the format did not move. Here are the two documents that
come out of exactly that. So the colours are not decorative: **pokemon wears the
same yellow as the at-rest `content` block, minecraft the same red as the block
after the click, white text and all.** Read left to right, it is the animation.

❌ **Reversed, do not restore:** this was **three** columns (pokemon amber /
minecraft green / mario red), rhyming with figure slide 1's three stacked rows.
Mario was cut and minecraft moved green → red to build the stronger rhyme with
figure slide 2 instead. Two side effects, both good: **green retired from the
deck entirely**, and the two sheets on screen are now exactly the two topics
from the Act 1 cold open — pokemon, and the minecraft one it drifted into.
`images/handwriting-good-mario.png` is now unreferenced.

- **What carries it is what doesn't vary.** Same `.qmd` box as the figure, same
  190×124, and the teal `yaml` band byte-identical in both columns. Only the
  content block changes: one word, one colour, one text ink. The two SVGs are
  verified identical apart from that — keep them that way, it's the argument.
- **The two colours are the figure's two states, not thematic ones.** pokemon =
  content yellow `#edae49` + navy text; minecraft = red `#d1495b` + **white**
  text. Both pairs are copied exactly from the `content` block on figure slide 2
  before and after its click. Don't "fix" minecraft to green because minecraft
  is green — that reading was tried and cut.
- **pokemon wears the plain content colour, and that's deliberate.** It is the
  sheet from the cold open and the un-edited one, so the column that changed
  nothing is the column still in `content` yellow.
- **No `render` label under the arrows** — repetitions of a word the previous
  slide just taught. Same rule as `#loop`: anything inside a repeated unit is
  paid for per copy.
- These two SVGs use **no ids and no markers** — arrowheads are explicit
  triangles — so they add nothing to the document-wide id namespace. Keep it
  that way if you copy the pattern.

Mechanics: pure inline SVG in a ```` ```{=html} ```` block + reveal fragments — no
anime.js, no CDN, nothing to vendor. **Both figure slides carry the identical
`viewBox="0 77 1240 553"`** (slide 1's three rows are centred on y = 175 / 361 /
547), and each carries **its own `<defs>`**, including its own `<clipPath>`
(`artifactClip` / `artifactClip2`); they deliberately do *not* share one `<use>`
across slides, because reveal puts non-current slides in `display:none` and
cross-slide `<use>` resolution is unreliable there. SVG ids are unique across the
whole document (`ahDark`/`ahDark2` etc.) — keep them that way. **The shared
viewBox is what registers the two slides** and it also means both render at the
same scale, so a box on slide 2 is physically the same size as the matching box
on slide 1. Don't shrink slide 1's width to close up its margins: it would break
the mirroring *and* it would shrink the height budget, since the figure is laid
out to fill the 1420 px of usable slide width.

**The viewBox top is a crop, not layout.** It doesn't start at y=0: the headings
moved out to lexis lines and the `min-y` reclaims the space their `<text>` held.
Every coordinate *inside* both SVGs is unchanged and unshifted — do not renumber
them to make the boxes start at zero. Slide 1 sits 40 units below the top and 25
above the bottom; slide 2 needs the extra top room because its `.qmd` label
(baseline y=101) is the highest thing on either slide.

**All four arrowhead markers use `refX="5.5"`, not `7`.** `markerUnits` defaults
to `strokeWidth`, so the head scales with the line. Putting refX on the tip (7)
parks the point exactly at the path end, and near that point the triangle is
narrower than the stroke is thick — so the line's butt-cap pokes out through the
tip. Backing refX off by 1.5 marker units slides the head forward until the
stroke ends where the triangle is already wider than it. Consequence: **the
visible tip lands 1.5 × stroke-width beyond the path end**, so path endpoints are
written with that overhang already subtracted (e.g. the connectors stop at
y=322/508 to land ~3 units above the `me` boxes at y=329/515). If you ever change
a stroke width, re-check the arrow's landing gap.

**Not yet visually vetted.** Coordinates are computed, not eyeballed — every
`<use>` and transform is resolved by script, and each dot and block is checked
to sit wholly inside the oval — but nothing here has ever been rendered.
Text-on-fill contrast is no longer a worry: every pairing was measured when the
palette moved to minou (see Palette), and the labels were flipped to navy
wherever white failed.

What to look at on the first render:

- **Does the whole thing fit?** This is the live risk. Slide 1 now renders ~633
  px tall in a 795 px box that the heading already takes ~100 px of, so the
  slack is ~60 px. If it clips, the knob is the row spacing (186) — not the
  viewBox width, which would make it worse.
- **The stripe crescents.** The two end stripes of the oval taper to slivers at
  the rim. Intended, but worth confirming they don't read as a rendering fault.
- **`max-height:80vh`** has still never been observed binding. On a short, wide
  browser window it now could, at which point the figure just scales down
  whole — graceful, not broken.

Slide 1's aspect (1240 × 553) is still wider than 16:9, so **width** binds the
scale, but **height is what binds the design** — see the arithmetic in the
registration note. To make its type bigger, raise the font sizes; narrowing the
viewBox is ruled out by the shared-viewBox rule above and by the height budget.

**The old me/agent asymmetry is resolved.** Slide 1's and slide 2's `me` /
`LLM agent` boxes were once 110/180 and 96/156 at different x. They are now the
same boxes at the same coordinates (me x=285, agent x=485), which is what makes
the at-rest registration byte-for-byte rather than approximate.

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

`custom.css` holds only what lexis does not ship — plus the palette, which is
the one thing in there that deliberately *overrides* lexis rather than adding to
it. It opens with a comment block restating the whole Palette section above;
keep the two in sync. Contents:

- **The semantic colors.** `.amber` is ours (the ink yellow `#A77400`, since it
  is only ever text); `.blue` / `.red` / `.green` override lexis's defaults so a
  `[word]{.blue}` on a slide is the same teal as the format band in the figure.
- **`.contentchip` / `.formatchip`** — the vocabulary chips. See Palette for why
  these exist rather than more colored text.
- `.amberborder` / `.blueborder` — colored image borders following lexis's own
  wrapper-div pattern (`.treatment img`), so they go on a **wrapping div**, not in
  the image's attribute block: `::: {.col .blueborder}`. Used on the "I want
  *this* layout, with *these* sentences" slide to tie each colored word to an
  image. **Fills, matching the chips** — the border is the chip's echo, so the
  eye connects word to sheet. 10px rather than lexis's 6 because the yellow is
  light and needs the area to read; that number is the knob if it looks faint.
- **A commented-out `.lift` rule** — the removed slide-up on entanglement figure slide 1, kept with its arithmetic in case it is ever wanted back.

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
  never been rendered — coordinates are computed by script, not eyeballed. See
  "What to look at on the first render" in the figure section. The live risk is
  **whether slide 1 fits**: it renders ~633 px tall with ~60 px of slack under
  the heading, and the knob is the 186-unit row spacing. Also check both slides'
  fragment steps build the way they're meant to, that the ±140 glide reads as
  the chain *opening* rather than as things scattering, and that the oval's end
  stripes don't look like a clipping bug.
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
