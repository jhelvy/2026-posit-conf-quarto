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
| 7:30–13:30 | **4. Scale it** ⭐ | The dashboard, 6 min, deliberately mid-deck so overrun can't reach it. Recording, what the agent wrote vs. never touched, spine (2/3), 2 patterns + 2 pitfalls |
| 13:30–16:00 | **5. Why it converges** | "So why not just ask for HTML?" — steelman it, live inline chart, *this deck is a `.qmd`*, then: **HTML can't tell you it's broken; `.qmd` has a compile step.** Checkable by machine + human. Caveat |
| 16:00–18:00 | **6. Close** | Change one word. Monday practicum (3 lines). *Software solved this decades ago.* Spine (3/3). Hand off to the session |

## Files

- `index.qmd` — the deck (RevealJS). Canonical, lives at repo root.
- `custom.scss` — the theme (see Styling). Applied via `theme: [default, custom.scss]`.
- `abstract.md` — canonical title + abstract + bio. Already live in the program.
- `talk-framing-decision.qmd` — the decision memo behind every choice above
  (why the thesis talk over the dashboard talk, why not the three words, why no
  Thariq, why the figure was redesigned). Read it for the *why*.
- `images/entanglement-diagram/` — the figure. **Both existing `.qmd` files there
  are outdated** (see below).

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

**Both files in `images/entanglement-diagram/` are outdated** — `entanglement-anime.qmd`
(5-click single-row transform with nested boxes) and `entanglement-diagram.qmd`
(older two-slide version). Neither reflects the current design. Rebuild rather
than patch.

## Styling

Port of John's xaringan "lexis" theme (from `2026-ies-symposium/css/`) to
Quarto RevealJS. Keep this look:

- **Fonts:** Inter (body), Fira Sans Condensed (headers), Lobster Two (`.fancy`),
  system mono for code.
- **Slides:** light gray bg (`#EAE9EA`), black text. `.inverse` slides = black bg,
  white text (used for section dividers and statement slides).
- **Utility classes** available: color classes (`.blue .red .green .darkgreen
  .orange .amber .purple .gray` …), font-size classes (`.small .large
  .font10`–`.font200`), float column classes (`.leftcol`/`.rightcol`,
  `.leftcol60`/`.rightcol40`, …), `.fancy`, image helpers
  (`.border .circle .polaroid`).
- `.amber` in the theme matches the figure's amber so deck and figure stay
  consistent.

## Hard rules

- **Never run `quarto render`** or any render command. Make changes, report done,
  let John render in his own terminal.
- **Never run `git` commands.** John commits/pushes himself.
- Simplicity first; surgical changes; match existing style.
- Paraphrase external sources; no long quotes.
- Section dividers are **statements, not labels.** Never put "Act 3" or a category
  name on a slide — that reintroduces the taxonomy problem.

## Open / to do

- **Rebuild the entanglement figure** to the "when does it weave?" design above.
- **Produce demo assets.** Placeholders in `index.qmd` are marked `[SCREENSHOT]
  [PDF] [CSV] [RECORDING] [FIGURE] [INLINE CHART]`:
  - handwriting sheet: the drifted version, the "fixed"-but-different version,
    and the CSV-rendered version
  - silent dashboard screen recording (~75s)
  - the live inline interactive chart for Act 5
- **Fill the four dashboard placeholders** — 2 patterns, 2 pitfalls. These are the
  most-remembered slides in a practitioner talk; they need real lived content.
- **Multi-turn token data** — Act 3's second slide is a placeholder. The published
  blog post has single-shot numbers only; the multi-turn/agentic cost growth
  section isn't live yet. Needs John's numbers. Never invent them. Frame it as the
  measured version of the Act 1 anecdote (one edit → full regeneration → full
  price), not as a second benchmark.
- Optional: email the three co-speakers to compare notes (Blake's talk is also
  AI-adjacent — his angle is data made *consumable by* AI, this one is AI
  *producing* artifacts; complementary, but check the setup slides don't collide).
