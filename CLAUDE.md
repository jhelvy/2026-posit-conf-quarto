# CLAUDE.md

Project instructions for this repo. The full design rationale lives in
`HANDOFF.md` — read it for the *why*. This file is the operational summary plus
the decisions made since.

## What this repo is

The slide deck for a **20-minute posit::conf 2026 talk**:
**"The Unreasonable Effectiveness of Quarto"** (canonical title + abstract in
`abstract.md`). Built as a **Quarto RevealJS** deck (`index.qmd`). Audience is
Quarto-literate. **No live demos** — everything is pre-rendered, screenshotted,
or embedded directly in the slides (embedded interactive HTML is itself evidence
the approach works).

## The thesis (don't let it drift)

- **Entanglement:** when an LLM generates a finished document, content and
  structure come out fused in one probabilistic pass. Nothing is guaranteed.
- **Disentanglement:** Quarto is an abstraction layer — the agent writes the
  `.qmd` (structure/logic); content that must be exact lives in data files and
  renders deterministically. You *architect* correctness instead of prompting
  for it.
- **Correctness is the headline; token savings are the bonus.** Never reorder these.
- **Thariq's "Unreasonable Effectiveness of HTML" is a foil you concede to**, not
  attack. Quarto keeps everything HTML wins and adds provenance HTML can't.
  Win by addition, not rebuttal.
- The **handwriting-sheet-for-my-6-year-old** PDF is the emotional/legible center —
  it proves the point is about *sentences*, not just data. Keep it.

## Structure (6 sections → see `index.qmd` and HANDOFF.md §5)

1. How does an LLM make a document? (entanglement opener)
2. Disentanglement, via the handwriting example
3. This is how you build anything (data products)
4. Enter Thariq — and you give up nothing
5. The dashboard payoff
6. Close — "just add a `q` in front of `md`"

## Files

- `index.qmd` — the deck (RevealJS). Canonical, lives at repo root.
- `custom.scss` — the theme (see Styling). Applied via `theme: [default, custom.scss]`.
- `abstract.md` — canonical title + abstract + bio. Source of truth for wording.
- `HANDOFF.md` — full design rationale, figure design rules, open decisions.
- `images/entanglement-diagram/entanglement-anime.qmd` — **the entanglement
  figure, canonical design direction.** Single-slide anime.js version that
  transforms in place across 5 clicks. Uses anime.js (CDN) driven by reveal
  `fragmentshown`/`fragmenthidden` events — Emil Hvitfeldt's tidy-animations /
  slidecraft "Fragments - JS" mechanism. Gets embedded into `index.qmd` (currently
  `[FIGURE]` placeholders) once finalized. Current design (after several rounds of
  iteration — keep these straight, earlier descriptions are wrong):
    - `Me · LLM agent · .qmd · output` all sit on ONE row (same height).
    - **Data box is FIXED** in the lower middle and never moves. Only its outgoing
      arrow retargets: → agent (LLM world) becomes → `.qmd` (Quarto world).
    - **No dashed "Quarto" container.** The `.qmd` is just a blue box on the row.
    - **Output is ALWAYS content + format fused**, shown literally: outer box =
      format (blue), inner box = content (amber).
    - **The payoff is correctness, NOT separation.** LLM world: content is
      ragged + red-dashed, "?" badge, "content may be wrong". On Quarto render the
      content snaps clean/amber, fills the format box, "content is exact". Format is
      always fine in both worlds.
    - 5 clicks: (1) prompt + data→agent; (2) generates → wrong fused output +
      review loop; (3) `.qmd` appears, agent *writes* it, data arrow swings to
      `.qmd`; (4) render → content snaps correct; (5) green *you edit directly*
      arrows to `.qmd` and data.
- `images/entanglement-diagram/entanglement-diagram.qmd` — older **two-slide
  version** (States A→B, reveal fragments + auto-animate). Superseded by the anime
  version AND conceptually outdated (its "fused stripes → clean halves" output was
  the wrong model — output is always fused). Kept only as a fallback; do not treat
  its design as current.

## Styling

Port of John's xaringan "lexis" theme (from `2026-ies-symposium/css/`) to
Quarto RevealJS. Keep this look:

- **Fonts:** Inter (body), Fira Sans Condensed (headers), Lobster Two (`.fancy`),
  system mono for code.
- **Slides:** light gray bg (`#EAE9EA`), black text. `.inverse` slides = black bg,
  white text (used for section dividers and statement slides).
- **Utility classes** carried over and available: color classes
  (`.blue .red .green .darkgreen .orange .amber .purple .gray` …), font-size
  classes (`.small .large .font10`–`.font200`), float column classes
  (`.leftcol`/`.rightcol`, `.leftcol60`/`.rightcol40`, …), `.fancy`, image
  helpers (`.border .circle .polaroid`).
- **Figure color vocabulary (never break it):** amber = **content**,
  blue = **format/structure**, green = **human's direct action**. `.amber` in the
  theme matches the figure's amber so the deck and figure stay consistent.

## Hard rules (from global CLAUDE.md — repeated because they bite here)

- **Never run `quarto render`** or any render command. Make changes, report done,
  let John render in his own terminal.
- **Never run `git` commands.** John commits/pushes himself.
- Simplicity first; surgical changes; match existing style.

## Open / in-progress

- **Entanglement figure (anime version):** design is settled (see Files); paused
  mid-polish. Not yet verified in a live render. When resuming, things to confirm /
  decide: that anime.js animating SVG `x`/`width`/`stroke` attributes actually
  reshapes the content box; whether the data arrow should *pivot* (single rotating
  arrow) instead of crossfade between two arrows; whether to merge clicks 3+4 so
  the output is never "orphaned" for a beat; the optional explicit crossed-out
  `agent ✗ data` arrow (the data-reroute may already say enough). anime.js is
  loaded from CDN — vendor it locally before the actual talk if presenting offline.
- **Embed** the finalized figure into `index.qmd` (replace the `[FIGURE]`
  placeholders on the two figure slides).
- Produce demo assets: handwriting PDF screenshots, stale-vs-rerendered report
  screenshots, the in-slide interactive chart (§4), the silent dashboard recording.
- Placeholders in `index.qmd` are marked `[SCREENSHOT] [PDF] [CSV] [RECORDING]
  [FIGURE] [INLINE CHART]` — each is a slot John will fill.
