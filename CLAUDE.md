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
| 2:30–5:30 | **2. The move** | Entanglement = no address. The figure. `.qmd` + CSV. Spine sentence (1/3). *Architect, don't prompt* |
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
| `handwriting-practice-minecraft.{png,pdf}` | Act 1 — the drifted version, eight rounds later |
| `vehicletrends.gif` | the teaser slide right after the title |
| `fig-tokens.png` | Act 3, token cost |
| `africa-bad.jpeg` | Act 5 |
| `africa-correct.png` | **currently unreferenced** by `index.qmd` |

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
SLIDE 1 — ASK FOR THE DOCUMENT
   [ me ] ──▶ [ agent ] ═══════▶  ▓▒▓▒▒▓▓▒   run 1     ← swaps in place
      ▲          (dashed)          ↑                      to run 2, run 3
      └──── review & re-prompt ────┘  woven here, probabilistically

SLIDE 2 — ASK FOR THE SOURCE
   [ me ] ──▶ [ agent ] ──writes──▶ [ .qmd ]  ┐
      │          (dashed)                     ├─render─▶ ▓▒▓▒▒▓▓▒
      └──── you edit directly ──────▶ [ data ]┘   woven here, deterministically
```

Design rules, in force:

- **Never draw content as a box inside a format box.** Containment implies the two
  are already separate and nested, which is the visual opposite of entanglement.
  Use a **striped bar** — irregular stripes, content and format interleaved.
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

**Slide 1 shows variance by swapping in place.** Three documents (`#doc`,
`#docRun2`, `#docRun3`) occupy the same slot and replace each other across two
clicks: `fragment fade-out` at index 1, `fragment fade-in-then-out` at index 1,
`fragment` at index 2. **The replacement is the argument** — each new run doesn't
sit beside the last one so you can pick, it destroys it. That is the eight-rounds
story, generalized. A fanned-out layout was considered and rejected for exactly
this reason.

**Slide 2 ends in ONE output, and it is byte-identical to slide 1's run 1.**
`#docOut` is a hand-kept copy of `#doc` — **if you edit one, edit both.** The
claim is *not* "this makes a better document"; it's that the weaving moved
somewhere you can reach. Losing that identity silently turns the figure into an
argument for determinism, which is the wrong takeaway (a better model doesn't fix
entanglement).

Mechanics: pure inline SVG in a ```` ```{=html} ```` block + reveal fragments — no
anime.js, no CDN, nothing to vendor. Each slide is `viewBox="0 0 1240 470"`, and
each carries **its own `<defs>`**; they deliberately do *not* share one `<use>`
across slides, because reveal puts non-current slides in `display:none` and
cross-slide `<use>` resolution is unreliable there. SVG ids are unique across the
whole document (`ahDark`/`ahDark2` etc.) — keep them that way.

**Not yet visually vetted.** Coordinates are hand-computed; bounding boxes were
checked on paper but never rendered. Likeliest cosmetic fixes: the `writes` label
wedged between the agent and `.qmd` boxes on slide 2 (~50px clearance), and the
green edit arrows' clearance under the `data` box.

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
  the two likeliest collisions. Check both slides' fragment steps actually swap
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
