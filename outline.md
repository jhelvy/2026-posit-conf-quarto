# The Unreasonable Effectiveness of Quarto — Outline

*Braided structure, 2026-08-16. Supersedes the problem → dashboards → cost →
correctness → payoff order.*

**Core theme:**

> **Agents should write the source, not the artifact.**

**Main argument:** When an agent generates a finished document, the content is
entangled with the structure, and modifying it is impossible without going back
to the agent. The pass is probabilistic, so the user has no control. Ask for a
`.qmd` instead and every piece of data has an address you **control** — which
also turns out to be **cheaper**, and to produce **correct** output that scales
to real data products.

**The escalation:** a kid's worksheet → a government slide with every country
wrong → a live dashboard over 169,552,665 records.

---

## The organizing principle: the braid

The talk is not five sequential acts. It is **three arguments, each played
twice** — once on a worksheet, once on a dashboard.

| | small case | same move, bigger document |
|---|---|---|
| **Control** | handwriting sheet, 8 rounds, the two figures | vehicletrends.us: 15 `.qmd` files, not an app |
| **Cost** | one paragraph, four sources, the token chart | the agent opens one page, never the site |
| **Correctness** | the Africa map | numbers computed at render, CI that fails loudly |

Three consequences, and they're the whole reason for the reorg:

1. **The dashboard never becomes a section.** It appears three times, so nobody
   spends the talk waiting for it. This answers the practice-run note *"put the
   dashboard somewhere earlier on."*
2. **Every C is named while its example is still on screen.** In the old order
   Control got labelled twenty slides after the handwriting sheet and had
   nothing to attach to.
3. **The audience learns the shape.** By the third repetition they anticipate
   the scale-up, which is the point at which a talk stops feeling like a list.

**The line that carries it, said three times, verbatim:**

> **"Same move. Bigger document."**

❌ Never say "Act 2" or "second movement" out loud. The braid is felt, not
announced. Section dividers stay statements.

---

## Act 0 — Open

Title → `vehicletrends.gif` → the Quarto mark → the mark beside the AI chip →
`dashboards.png` full-bleed → **the promise**.

- The gif is **provenance, not proof**. *I built this with Quarto.* Don't
  explain how — that's the rest of the talk.
- ❌ Never explain the title. It's a genre (Wigner, 1960), and it gets paid off
  in Act 5, not here.
- The promise slide (**"Give me four minutes"**) is the practice-run note
  *"glimpse into here's what you'll see in the rest of the talk"* — but it buys
  the handwriting section with a **number**, not a table of contents. An
  audience told "four minutes" waits four minutes.
- ❌ Still don't list Control / Cost / Correctness here. The glimpse is the
  promise that the worksheet leads somewhere, not a preview of the spine.

---

## Act 1 — Control

### First movement: the handwriting sheet

The worksheet, the prompt, the pokemon draft, *eight rounds later*, the
minecraft keeper. Then the turn: **I wanted these sentences with this layout**,
and asking for the document asked for both at once.

- **Entanglement is operational, never metaphorical: the content has no
  address.** No file, no line, no cell *is* a given sentence.
- Entanglement figure 1 → figure 2. The weaving moves to render time.
- **NEW — the source slide.** `practice.qmd` beside `sentences.txt`. *The model
  wrote the left, once. I edit the right.* This is where the abstraction becomes
  a file the room can see. Everything before it is claim; this is the seam.
- *Same format. No drift.* → **Ask for the source, not the artifact** → in
  Quarto, that source is a `.qmd`.

### Second movement: same move, bigger document

The gif returns. **"Same move. Bigger document."**

- `Same picture. Bigger artifact.` — the entanglement figure redrawn at site
  scale, three slides after its twin so the callback is free.
- **It's not a 3,000-line dashboard. It's 15 small documents.** Plant
  `library(vehicletrends)` here; Act 3 comes back for it.
- **It's not an application. It's a document.** Early on purpose: the room has
  been silently asking *"why isn't this Shiny?"* since the montage, and you
  can't argue cost to people stuck on that question. Honest concession stays —
  server-side compute over browser-too-big data is Shiny's turf.

**Ladder:** Control earned, Cost arrives.

---

## Act 2 — Cost

### First movement: one paragraph

The rendered card, then the same paragraph as `.qmd` / LaTeX / HTML, then Word.
Then the experiment figure (*two ways to ask for the same document*), then
`fig-tokens.png`.

- Counts are measured, not estimated. HTML costing more than LaTeX is not a bug.
- **The sharper claim, said out loud at the chart:** it is not that markdown is
  smaller — **it is that you stop paying for the parts you did not change.**
  Character count is the proxy; regeneration is the mechanism.
- ~81,000 tokens vs ~11,000 after ten edits. *The ratio never moves; the gap
  does.* ❌ Don't rebuild this as a chart — see `CLAUDE.md`.

### Second movement: same move, bigger document

**"Same move. Bigger document."**

- **Small pieces have small context windows.** The whole site is 15 pages and
  ~3,000 lines; the agent opens one, 200–600 lines. The whole dashboard is never
  in scope at once, and neither is the token bill.
- This is the strongest AI-specific slide in the talk, and in the old order it
  was buried sixth in a nine-slide feature tour.

**Ladder:** Cost earned, Correctness arrives.

---

## Act 3 — Correctness, and the road to trust

### First movement: the Africa map

- ❌ **Never claim who or what made it.** The claim is what it *demonstrates*:
  **a wrong artifact looks exactly like a right one.** It rendered, it shipped,
  nobody caught it.
- **This map has no failure mode.** Harder line if you want it: *there is no
  version of this that throws an error.*
- **Same map, from source.** `stopifnot(all(funding$name %in% africa$name))` is
  the whole slide. The turn is *drawn vs. joined*: join names to a shapefile and
  a wrong name fails; draw the shape and there's nothing to fail.
- **Quarto is checkable twice** — by machine (`quarto render` is a compile step)
  and by human (plain text, so the edit is a diff; review scales with the
  change, not the document).
- **HTML is good, but it can't tell you if it's broken.** Make the HTML case at
  full strength as the objection, then turn: malformed HTML still renders as
  *something*, so the agent can't tell whether it succeeded.

### Second movement: same move, bigger document

**"Same move. Bigger document."** — the third and last time.

- **NEW — the same move, one more time.** `library(vehicletrends)`: the number
  is computed at render, and a GitHub Action re-renders the whole site every
  Sunday at 5am. If the data moved and a page no longer builds, **the build
  fails before anyone reads it.**
- Deliberate callback: point at `library(vehicletrends)` and say *you have seen
  this line already — in the control section it was about the agent not having
  to write the numbers; here it is about nobody being able to write the wrong
  one.*
- **This is where trust lands.** Trust isn't asserted; it's the name for what
  you have once the numbers have addresses and the build can fail. *You can't
  prompt your way to correctness. You architect it.*

**Ladder:** all three earned.

---

## Act 4 — Victory lap

Everything Quarto composes for free, now that the argument is finished. This is
**a lap, not a section** — keep it to four or five slides or it re-forms into
the feature tour the braid dissolved.

Every page gets a URL · interactivity in the browser (live `echarts4r`, legend
filtering) · put the heavy thing in a box (the `hhi-map` iframe) · drop a whole
Shiny app in the page (Shinylive → WASM) · it's just static files, hosted free.

Closes on **It looks like an application. It isn't.** — *no piece has to
understand the whole thing. Neither does the agent.* That is the right last
thing before the close: it hands the lap straight back to the thesis.

❌ Never present the lap as "N reasons Quarto is good for dashboards." That's a
catalogue, and it's the failure mode this outline names by name.

---

## Act 5 — Close

1. **You don't need to know Quarto to start.** Change one word: ask for the
   `.qmd`.
2. **Where this gets annoying** — real pitfalls, honestly named, twenty seconds.
   Buys credibility and makes the next slide read as mitigation.
3. **Make this work Monday** — `quarto render` in `CLAUDE.md`; agent works on a
   branch so edits arrive as diffs; data in files the `.qmd` reads, never in the
   prompt.
4. **Software solved this decades ago.** Source and artifact. Documents are only
   getting there now — *right when the authors became probabilistic.*
5. **Quarto wasn't built for this.** Nobody was thinking about agents in 2022.
   It works anyway — that's the unreasonable part. (The title, paid off at the
   end. ❌ Don't explain Wigner.)
6. **Agents should write the source, not the artifact.**

---

## Carried from the practice-run notes

- ✅ **Dashboard earlier** — solved structurally by the braid; it now appears in
  all three acts.
- ✅ **Glimpse of what's coming** — the "give me four minutes" promise, without
  spending the spine's reveal.
- ✅ **Trust** — named in Act 3's second movement, where it's earned rather than
  asserted.
- ⬜ **The blog post** — you wrote up how the site was built and it isn't
  referenced anywhere. Cheapest home is a URL on the closing slide or under the
  15-documents slide. Decide which; don't spend a slide on it.
- ⬜ **"Where to take AI out of the loop"** — the diagram idea from the notes
  (top half → Africa map → bottom half → trust). The correctness act now does
  this in three slides without a new figure. Only build the diagram if the three
  slides fail on a run-through; a fourth figure in a 20-minute talk is expensive.
- ⬜ **Walk the hook completely** — the open currently gets four slides before
  the promise. Time it; if the gif is doing the work, one of the middle three
  can go.
- ⬜ **Contact sheet of the eight drafts** — *eight rounds later* is asserted,
  not shown. If the drafts survive, a 3×3 of the rejects plus the keeper is the
  cheapest big win left in the deck.
