# The Unreasonable Effectiveness of Quarto — Outline

posit::conf 2026 · 20 min slot
Session: "Dashboards" (really: **data products**) — this talk is first, and is the
session's thesis statement.

*Timing deliberately omitted. Structure first; we'll budget minutes once there's a
full deck.*

**Spine sentence, said 3×:**
> **Agents should write the source, not the artifact.**

**One-line argument:** When an agent generates a finished document, the content has
no address — you can't point at a sentence, so you can't fix one. Ask for the `.qmd`
instead and every piece gets an address. First that buys you **control**, then it
turns out to be the only way to be **correct**, and then it scales all the way to a
real data product.

**The escalation (felt, never listed on a slide):** stakes climb from a kid's
worksheet → a government slide with every country wrong → a live dashboard over 10M
records. **Efficiency is not a step on that ladder** — it's a thirty-second surprise
attached to the move in Act 2, and it comes back in Act 4 as architecture. Never a
pillar, never its own act.

---

## Act 1 — The problem, unnamed

**Main point:** I couldn't change one sentence. Not because it was wrong — because
there was nowhere to reach in. No thesis yet, no agenda.

- Cold open: handwriting practice sheet for my six-year-old. Minecraft version.
- Ask again for a different topic → **a completely different document.** I changed
  the content and the format changed with it.
- Try to fix one sentence → the whole page is rebuilt, differently.
- The question that runs the rest of the talk: **"Where is the sentence?"**
- ⚠️ This is a **control** story, not a correctness story. Nothing here was wrong.
  Say so — it keeps the stakes low and disarming, and it leaves correctness as a
  live surprise for Act 3.
- Defusing line so the room doesn't hear a recap: *you already know content and
  format should be separate — that's not the news. The news is what breaks when an
  agent is the author.*

**Assets:** minecraft sheet ✅ · pokemon sheet ✅ · (maybe) the "fixed but different"
version ❌

---

## Act 2 — The move

**Main point:** The failure has a name and a fix. Entanglement = **the content has
no address.** Disentanglement = **give it one.**

- Entanglement defined operationally, never metaphorically: in a generated document
  there's no file, no line, no cell that *is* that sentence. It's smeared across one
  probabilistic pass. To change it, you regenerate everything and hope.
- The fix: agent writes the `.qmd` (structure, layout, logic); the sentences that
  must be exact live in a CSV and get typeset deterministically. **A row is an
  address.**
- **[optional] The diagram slot.** Goes here if it goes anywhere — right after the
  concrete example, to codify it. Its one job: show the *identical* output arriving
  by two routes, and that the only difference is **when the weaving happens** and
  whether you can reach in before it does. Undecided; don't build until called.
- ⚠️ *Two tiers — don't blur them.* Prose stays in the `.qmd`; its address is a line
  number and a readable diff. Only **values that must be exact** go to data + code.
  The move is "stop asking for the artifact," never "extract everything."
  (Pre-empt the "so I put my prose in a spreadsheet?" objection here.)
- **Spine sentence (1 of 3).**

### …and, unexpectedly, it's cheaper *(coda to Act 2 — short, not its own act)*

- *"Here's what I didn't expect when I started doing this."*
- Token table: same prompt, same model, only the output target changes. Direct
  output swings wildly (8,097 for Word); via `.qmd` it's flat at ~1,000 every time.
  Point at the **shape**, not the numbers. Keep the honest row (Markdown = a wash).
- Verbal callback, no slide: *I paid full price to change one sentence.* An edit to a
  fused artifact regenerates the whole thing; an edit to a `.qmd` is a diff.
- **Reproducibility used to be a tax. Now it's the discount.** The virtuous path
  became the lazy path.
- ⚠️ Keep it short and keep it here. It sits next to the artifact it measures, and
  the surprise only works before the room knows this is an architecture talk. It
  returns in Act 4 as *small pieces have small context windows* — same effect,
  promoted from benchmark to structural property.
- **Cut:** the old "and that's just the first turn" slide. Numbers don't exist; the
  point lands verbally.

**Assets:** CSV + qmd side-by-side ❌ · rendered-from-CSV sheet ❌ · single-shot
token table ✅ · `[FIGURE]` (TBD)

---

## Act 3 — And it's the only way to be right ⭐ NEW

**Main point:** So far this was about control. Here's where it stops being about
convenience. **This failure mode has no prompt-shaped fix.**

- The Africa map: a real US State Department slide, shown at an international
  conference, where **every country is mislabeled.** Shapes that aren't the
  countries they point at. It rendered beautifully. Nothing flagged it.
- ⚠️ **Not an AI-dunk.** The argument is not "look, the model got it wrong." It's:
  you cannot ask more nicely for the borders to be right. Asking again gets you a
  different wrong map. The failure isn't in the prompt — it's in *what you asked
  for.*
- The corrected version: built from actual geodata with a few lines of code.
  It **cannot** mislabel a country, because the shapes and the names come from the
  same rows. The countries have an address.
- **Punchline lands here** (moved out of Act 2, where it was an assertion — here
  it's a demonstration):
  **You can't prompt your way to correctness. You architect it.**
- Segue into Act 4: now do that where it actually matters, at scale.

**Assets:** africa-bad.jpeg ✅ · africa-correct.png ✅

---

## Act 4 — Scale it ⭐

**Main point:** Same move, bigger artifact — and now control and correctness have to
hold at once, over and over, without me watching. This is how you build a **data
product**.

The centerpiece. Sits mid-deck on purpose, so running long can't eat it.

- **vehicletrends.us** — real, multi-page, self-updating Quarto site over 10M+
  vehicle listings. Silent screen recording as evidence, not a feature tour.
- **The handwriting sheet, forty pages over.** Agent wrote the `.qmd`s, the small R
  chunks, the glue. Agent never touched the data — it lives in an R package the
  pages read at render, so every number has an address and nothing goes stale.
  (Africa's argument, every number, every page, every week.)
- **"But why not just build a Shiny app?"** — name the objection first; it's the
  elephant in a Posit dashboards room. Shiny asks you to *assemble the artifact*
  (UI + inputs + outputs + server + reactivity) and then run a server to hold it up.
  Quarto: markdown + a chunk returning a widget the browser runs. Same PDF problem,
  one level up. **Honest concession:** server-side compute over browser-too-big data
  is Shiny's home turf.
- **Put the hard thing in a box.** The MapLibre/PMTiles map is a separate repo,
  iterated alone, dropped in via a 6-line iframe.
- **Small pieces have small context windows** — *the Act 2 callback.* Isolation is
  the efficiency argument made architectural. The whole site is never in scope at
  once, so every interaction stays cheap and every component stays individually
  correct.
- **It's just static files.** Charts, map, even the Shiny app (Shinylive → WASM) all
  run client-side. No server to run, secure, or pay for.
- **Spine sentence (2 of 3).**

**Assets:** ~75s silent recording ❌ · map screenshot ❌
**To verify:** GitHub Pages vs. Netlify — confirm what actually serves the site.

---

## Act 5 — Why it converges

**Main point:** **HTML can't tell you it's broken. A `.qmd` has a compile step.**

- Name the objection at full strength, in my own voice: *"So why not just ask for
  HTML?"* Steelman it generously — rich, viewable anywhere, no toolchain, and agents
  are very good at it. HTML is genuinely great for isolated subcomponents.
- Then turn: malformed HTML still renders as *something*, so the agent can't tell
  whether it succeeded. A bad chunk or cross-reference in a `.qmd` is a loud,
  deterministic error the agent reads and fixes without me.
  (Rhymes with Africa: *that map rendered fine too.*)
- **Checkable twice:** by machine (`quarto render`) and by human (plain text → the
  edit is a diff; review scales with the change, not the document).
- Proof by existence: **this deck is a `.qmd`**, and here's a live interactive chart
  in it.

**Assets:** live inline chart ❌

---

## Act 6 — Close

**Main point:** You don't need to know Quarto to start. Change one word.

- **Ask for the `.qmd`.**
- Monday practicum, three lines: put *"always run `quarto render` before finishing"*
  in `CLAUDE.md`; have the agent work on a branch so edits arrive as diffs; keep data
  in files the `.qmd` reads, never in the prompt.
- The rhyme: **software solved this decades ago** — source and artifact. Documents
  are only getting there now, right when their authors became probabilistic.
- **Spine sentence (3 of 3).**
- Hand off to the session: the next three talks are all about data products.

---

## Rules I'm holding myself to

- **Name the objection first** (Act 1: "we already knew that"; Act 4: "why not
  Shiny?"; Act 5: "why not HTML?").
- Section dividers are **statements, not labels** — never "Act 3," never a category
  name. In particular: **never a slide that lists control / correctness / cost.**
  The escalation is felt, not enumerated.
- **Don't argue for content/format separation — show it.** The room grants it
  instantly; arguing is what makes the talk feel like a recap.
- **Never explain the title.** It's a genre (Wigner, 1960) and stands alone. Never
  name anyone else's "Unreasonable Effectiveness of HTML."
- No three-pillar framing. No stale-report slide. No live demos.

---

## Open questions

1. **Keep the entanglement diagram?** Slot reserved in Act 2. It's the only thing
   that shows the same output arriving two ways — but the handwriting sheet plus the
   Africa map may already do that work with real artifacts. Still undecided.
2. **Does the Africa "corrected" version need to be Quarto?** It was built with a
   little Python/GeoPandas. Reads as broader (this isn't an R thing), or as
   off-message in an R room — probably a matter of the sentence said over it rather
   than anything on the slide.
3. **Multi-turn token numbers** — currently cut. If measured later they'd rejoin the
   Act 2 coda, but only if they can stay short; the coda must not grow back into an
   act.
