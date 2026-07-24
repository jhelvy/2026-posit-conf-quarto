# CLAUDE.md

Project instructions for this repo. **This file is the single source of truth.**

> `HANDOFF.md` is **superseded and historical.** It documents an earlier framing
> (three pillar words; a named concession to Thariq; a nested-box entanglement
> figure) that has since been deliberately reversed. Do not take design direction
> from it. It's kept only as a record — safe to delete.

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

- `index.qmd` — the deck. Canonical, lives at repo root. Uses
  `format: lexis-revealjs` — **read the Styling section before editing it**, the
  slide syntax is not stock Quarto reveal.
- `_extensions/lexis/` — the lexis format extension (installed, do not hand-edit).
- `custom.css` — one rule (`.amber`) layered on top of lexis. See Styling.
- `custom.scss` — legacy hand-port, now only used by the figure drafts.
- `abstract.md` — canonical title + abstract + bio. Already live in the program.
- `talk-framing-decision.qmd` — the decision memo behind every choice above
  (why the thesis talk over the dashboard talk, why not the three words, why no
  Thariq, why the figure was redesigned). Read it for the *why*.
- `images/entanglement-diagram/weave-figure.qmd` — **current** figure draft
  ("when does it weave?", see below). Renders clean; not yet visually vetted.
- `images/entanglement-diagram/entanglement-{anime,diagram}.qmd` — **outdated**
  earlier versions, left untouched as fallback. Do not treat as current.

Render status: `weave-figure.qmd` and `talk-framing-decision.qmd` render without
error. `index.qmd` rendered clean under the old hand-rolled theme; it has since
been converted to `lexis-revealjs` and **has not been re-rendered** (John
renders; agents do not).

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

**Design direction: "when does it weave?"** Two stacked rows with an **identical**
output at the end of each.

```
LLM ALONE
   [ Me ] ──prompt──▶ [ agent ] ═════▶  ▓▒▓▒▒▓▓▒▓▒▒▓   document
      ▲                                  ↑
      └────── re-prompt ──────┘          woven HERE, probabilistically

WITH QUARTO
   [ Me ] ──prompt──▶ [ agent ] ──writes──▶ [ .qmd ]  ┐
      │                                               ├─render─▶ ▓▒▓▒▒▓▓▒▓▒▒▓
      └──── edit ──────────────────────────▶ [ data ] ┘            document
                                                                      ↑
                                                        woven HERE, deterministically
```

- **The output is identical in both rows.** That's the whole point — the difference
  isn't what comes out, it's *when* the weaving happens and whether you can reach
  in before it does.
- **Never draw content as a box inside a format box.** Containment implies the two
  are already separate and nested, which is the visual opposite of entanglement.
  Use a **striped/smeared bar** — irregular stripes for the probabilistic weave,
  clean regular stripes for the deterministic one.
- **3 build steps max:** (1) top row entire; (2) bottom row skeleton, agent writes
  only the `.qmd`; (3) render arrow + green edit arrows.
- Its job in Act 2 is **generalization, not explanation** — the handwriting sheet
  already taught the idea. That justifies a simple picture.
- **Color vocabulary (never break it):** amber = **content**, blue =
  **format/structure**, green = **human's direct action**.

**Current draft: `weave-figure.qmd`.** Pure inline SVG + reveal fragments (no
anime.js/CDN — nothing to vendor). `viewBox="0 0 1240 690"`, base + 2 fragments =
3 states. The two output bars are ONE `<defs>` group `<use>`d twice, so they are
provably identical. Provenance drawn as an amber thread from the output back to
"row 3 of sentences.csv." Renders clean but is NOT yet visually vetted — the
coordinates are hand-computed, so expect cosmetic collision fixes.

**Open question John is weighing: whether the deck needs the diagram at all.** He
finds the concept possibly clearer via the handwriting-sheet + CSV example alone.
If kept, its job is *generalization, not explanation* (Act 2, after the concrete
example). Don't over-invest until he decides.

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

Two local style files remain:

- `custom.css` — loaded by `index.qmd` via `css:`. Holds **only** `.amber`, the
  talk's "content" color, which lexis doesn't ship. It matches the figure's amber
  so deck and figure stay consistent. Add nothing else here that lexis provides.
- `custom.scss` — the pre-extension hand-port. **No longer used by `index.qmd`**;
  still used by `images/entanglement-diagram/*.qmd`. Don't delete it until the
  figure is either ported to lexis or embedded into the deck.

## Hard rules

- **Never run `quarto render`** or any render command. Make changes, report done,
  let John render in his own terminal.
- **Never run `git` commands.** John commits/pushes himself.
- Simplicity first; surgical changes; match existing style.
- Paraphrase external sources; no long quotes.
- Section dividers are **statements, not labels.** Never put "Act 3" or a category
  name on a slide — that reintroduces the taxonomy problem.

## Open / to do

- **Decide whether to keep the entanglement figure at all** (see figure section).
  If yes, visually vet `weave-figure.qmd` and fix any coordinate collisions, then
  embed it into `index.qmd` Act 2 (currently a `[FIGURE]` placeholder there).
- **Produce demo assets.** Placeholders in `index.qmd` are marked `[SCREENSHOT]
  [PDF] [CSV] [RECORDING] [FIGURE] [INLINE CHART]`:
  - handwriting sheet: the drifted version, the "fixed"-but-different version,
    and the CSV-rendered version
  - silent dashboard screen recording (~75s)
  - the live inline interactive chart for Act 5
- **Dashboard assets for Act 4** — silent screen recording of vehicletrends.us
  (~75s); a screenshot of the MapLibre map on `market-concentration.qmd`. Act 4
  content itself is written (from the real repo); these are the visual slots.
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
