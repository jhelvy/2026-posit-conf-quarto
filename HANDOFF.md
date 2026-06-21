# Handoff: posit::conf talk — "Quarto as an Abstraction Layer"

This document hands off design work for a conference talk to a Claude Code agent
working in the talk's repo. It captures the argument, the finalized abstract, the
talk structure, the key figure and its design rationale, the assets already
produced, and the open decisions. Read it top to bottom before making changes.

---

## 1. The talk at a glance

- **Venue:** posit::conf. Audience is Quarto-literate — you can assume familiarity
  with `.qmd`, rendering, RevealJS, Shiny/Shinylive, R/Python code chunks.
- **Length:** 20 minutes, short. Budget ~18 min of content. Ruthless about scope.
- **Constraints:** **No live demos.** Everything is pre-rendered, screenshotted, or
  embedded directly in the slides. The slide deck itself is built as a `.qmd`
  RevealJS deck, so embedded interactive HTML output (plots, iframes, even
  Shinylive) is fair game and is itself evidence the approach works.
- **Speaker:** John Helveston (jhelvy). The talk extends his blog post (below).

## 2. The core thesis

The talk is an argument about **how to work with probabilistic systems**, not a
Quarto feature tour and not a rebuttal of anyone.

The central idea is **entanglement**. When an LLM generates a finished document
(HTML, Word, PDF), content and structure come out of a single probabilistic pass,
fused together. Nothing in that artifact is *guaranteed* — not the layout, not the
numbers, and not even the sentences. For a one-off static page that's fine. The
moment you need to *change* something, you're asking a probabilistic system to
modify a fused artifact and hoping it changes only what you wanted.

Quarto's move is **disentanglement**: the LLM generates structure and logic (the
`.qmd` scaffold), while the content that must be exact lives in data files and is
rendered deterministically. You are not prompting for correctness — you are
*architecting* the document so the parts that need to be exact never pass through
the model at all. The model does what it's good at (structure, logic, templates);
deterministic rendering does what it's good at (exactness).

Consequence to preserve in all materials: this reframing makes correctness the
headline (the claim nobody else is making) and token efficiency a secondary bonus.

## 3. Source material

- **Author's blog post (the talk's basis):**
  https://www.jhelvy.com/blog/2026-05-12-quarto-optimal-claude-output/
  Key contents: rich output through code; one source / any format; a token
  experiment; version control; content/presentation separation; "you don't need
  to know Quarto." Also teases Lua filters (not covered in the post).
- **Token experiment numbers (from the blog post)** — same prompt/model, varied
  output target. Asking for `.qmd` instead of the finished format reduced output
  tokens by roughly: **Word 7.2x, HTML 4x, PDF 1.8x**. The `.qmd` request stays
  flat (~1,000–1,100 tokens) regardless of the eventual target format.
- **Thariq's "The Unreasonable Effectiveness of HTML"** (X thread + companion
  examples site at thariqs.github.io/html-effectiveness/). Argues agents should
  output HTML over Markdown; went viral (millions of views). Organizes ~20 demos
  into nine categories (exploration/planning, code review, design, prototyping,
  diagrams, decks, research explainers, reports, custom editing interfaces).
  **Role in the talk:** not a foil to attack. Concede he's right that rich output
  beats Markdown walls, then show Quarto keeps everything HTML wins *and* adds
  correctness/provenance that HTML structurally cannot. His "custom throwaway
  editors" category is genuinely HTML's home turf — concede it; it buys credibility.

> Note for the agent: paraphrase these sources. Do not paste long quotes.

## 4. Finalized abstract (single paragraph, author-edited — canonical)

> Quarto markets itself as a publishing framework. But at its core, Quarto is an
> abstraction layer separating *content* from *format* — a distinction that turns
> out to be remarkably powerful in the era of AI agents. When an LLM generates a
> document, content and structure emerge together in a single probabilistic pass,
> but nothing in that output is guaranteed. Quarto's code-at-render-time model
> solves this by letting the LLM build the structure while allowing the content
> that must be exact to be rendered deterministically from data files. The result
> is reproducible and auditable output that stays correct as your content changes,
> without needing to re-prompt models. This talk brings the agent + Quarto workflow
> to life with concrete examples, from a simple one-page PDF to a fully interactive
> multi-page dashboard integrating JavaScript libraries, Shinylive, and React,
> showing how asking an LLM for a qmd file instead of a finished document
> dramatically reduces token overhead while producing more dynamic, reproducible,
> and maintainable output.

Only outstanding tweak: "allowing the content that must be exact **to be** rendered"
(added the "to be"). Otherwise locked. Do not reintroduce specific token numbers
into the abstract — "dramatically reduces" is intentional there.

## 5. Talk structure (20 min, correctness-first)

1. **Opening — How does an LLM make a document? (~3 min)**
   Philosophical walk-in. Content and structure are generated together in one
   probabilistic pass; fine for a static one-off, fragile the moment you want to
   change anything. Name the problem on one slide: *LLMs entangle content and
   structure. Neither is guaranteed.* (Audience knows Quarto, so the slow reveal
   builds tension; a small wink is fine.)

2. **The disentanglement — via the handwriting example (~4 min)**
   Introduce Quarto as the abstraction layer. Make it concrete with the marquee
   example: a **handwriting-practice PDF for the author's 6-year-old**, rendered
   `.qmd` → Typst → PDF. Generated directly, the sentences are only *probably*
   what you want. With Quarto, the sentences live in a CSV and the output is exact
   every time; editing is editing a text file. This proves the point is about
   *sentences*, not just data — and it disarms the room.

3. **This is how you build anything — data products (~4 min)**
   Generalize. The report whose CSV changed: the baked-in HTML report is now
   silently, confidently wrong; the `.qmd` re-renders correctly. Modular
   architecture — content in data files, logic in chunks, presentation in
   YAML/themes — each piece independently editable by human or agent. HTML solves
   presentation; it does nothing for provenance.

4. **Enter Thariq — and you give up nothing (~4 min)**
   Reposition the HTML argument from hook to foil. Concede he's right; show Quarto
   produces everything he shows. Embedded interactive chart *in the slide* ("not a
   screenshot"); the meta-reveal that **this deck is a `.qmd` file**; token
   efficiency compressed to one supporting slide. One honest concession: throwaway
   custom editors are HTML's home turf.

5. **The dashboard payoff (~3 min)**
   Short recorded walkthrough (no audio) of the multi-page dashboard
   (Shinylive + JS libraries + React), then one workflow slide
   (human + Claude Code + Quarto) and 1–2 real pitfalls/patterns. This is the
   payoff image, not a deep dive.

6. **Close (~2 min)**
   "You don't need to know Quarto" — change one word in your prompt. Point power
   users to Quarto skills / `CLAUDE.md`; Lua filters as the "there's even more"
   teaser. Land on: adding a "q" in front of "md."

Cut to Q&A ammunition, not slides: full category-by-category walk of Thariq's
site; deep Lua filter content; deep dashboard pitfalls.

## 6. The key figure (entanglement / abstraction-layer diagram)

A purely conceptual diagram — **never filled with real content**. It explains the
content/format entanglement idea and shows Quarto sitting between the user and the
model. It exists in two states the talk moves between.

**State A (naive):** `Me → LLM agent → output`. The agent generates the finished
output directly (content + format fused). The only way the human influences the
output is by re-prompting the agent (review loop). One lever.

**State B (Quarto):** Quarto sits in the middle gap as a dashed container holding
`.qmd` (structure) and `data files` (content). The agent **writes only the `.qmd`**
— it never touches the data. `.qmd` + data **render** to output. Crucially, the
human gains **direct edit arrows** into both `.qmd` and `data`, bypassing the
agent. One lever became three. That multiplication of arrows is the visual payoff.

### Design rules (follow these when editing the figure)

- **Color vocabulary, never broken:** amber = **content**, blue = **format/
  structure**, green = **human's direct action** (the edit arrows). Amber/blue are
  reserved strictly for the two concepts; green is a deliberate third accent so
  "you edit directly" reads as a different *kind* of arrow, not more content/format.
- **Fixed positions — nothing ever moves.** One `viewBox="0 0 960 540"`, every
  element at absolute coordinates. The three actor boxes (Me, agent, output) sit in
  their final positions with the middle **gap pre-built**, so the Quarto layer
  drops into empty space already waiting. A build step = toggling visibility or
  revealing a fragment; it is NEVER a position change. Keep the viewBox identical
  across every variant — that is the single thing that guarantees zero drift.
- **Abstraction only.** Boxes stay as clean labeled rectangles forever.
- Optional sharpening idea not yet added: a faint crossed-out arrow from agent
  toward the data box to dramatize "the model never touches your exact content."

## 7. Assets already produced

These files were generated in the design session and the author will add them to
the repo. Treat them as the source of truth for the figure geometry.

- **`entanglement-figure.svg`** — master source. All six build groups present and
  clearly id'd (`#actors`, `#persistent-arrows`, `#naive-only`, `#quarto`,
  `#quarto-arrows`, `#edits`). Header comment explains how to toggle group
  visibility to export either state, or how to convert to Reveal fragments.
  Renders by default in the full Quarto state (`#naive-only` hidden).
- **`entanglement-figure-1-naive.svg`** — standalone naive figure (State A) at
  identical coordinates, for perfect slide-to-slide registration.
- **`entanglement-slides.qmd`** — a 2-slide RevealJS deck that animates the build:
  boxes appear first, then each **arrow fragments in one at a time**. Both slides
  use `auto-animate=true` with matching `data-id`s on the actor boxes so they stay
  locked while the Quarto layer materializes. Arrow staging is controlled purely
  by `class="fragment"` + `data-fragment-index`. Shared styling is in one
  `<style>` block at the top; speaker notes are in `::: {.notes}` blocks.
  NOTE: not yet test-rendered with `quarto render` — verify fragment pacing and
  theme interaction locally; fixes are almost always just the index numbers.

## 8. Open decisions / next steps for the agent

- **Build the actual deck** from the Section 5 outline. Beyond the entanglement
  figure, no slides exist yet. The deck is a `.qmd` RevealJS file.
- **Confirm `quarto render` works** on `entanglement-slides.qmd` and the fragment
  timing feels right; adjust `data-fragment-index` values as needed.
- **Produce demo assets** (since no live demos): screenshot/recording of the
  silently-wrong-HTML vs re-rendered-`.qmd` correctness sequence; a short silent
  screen recording of the multi-page dashboard; the embedded in-slide interactive
  chart for Section 4.
- **Apply the talk's own theme** to the figure (`entanglement-slides.qmd` currently
  uses `theme: simple`); colors are explicit so retheming is one place.
- Decide: keep the review loop in State B (currently persists) or drop it there.
- Decide: add the optional crossed-out agent→data arrow.
- Decide: an optional third "clean final state" figure slide with labels stripped.
- Apply the one abstract grammar tweak ("to be rendered").

## 9. Tone guardrails (carry these into the writing)

- Concede Thariq's argument genuinely; the talk wins by addition, not rebuttal.
- Correctness is the headline; tokens are a bonus. Don't let the ordering slip back.
- Keep the handwriting example as the emotional/legible center — it makes the
  abstract idea land for non-data people.
- Paraphrase external sources; no long quotes.
