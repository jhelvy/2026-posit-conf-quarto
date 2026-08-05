# The Unreasonable Effectiveness of Quarto — Outline

**Core Theme**:

> **Agents should write the source, not the artifact.**

**Main argument:** When an agent generates a finished document, the content is entangled with the structure, and making modifications to it is challenging / impossible without going back to the agent. The pass is probabilistic, leaving the user with less control.

Instead, if you ask for a .qmd file, every piece of data has a source that you **control**, which also turns out to also enable **correct** outputs that scale to real data products like dashboards

**The escalation**: Stakes climb from a kid's worksheet → a government slide with every country wrong → a live dashboard over 10M records.

---

## Act 1 — making handwriting practice sheets

I could only go back to the model, then when I wanted something new, I couldn't keep it consistent

---

## Act 2 — Entanglement diagram

Agents are probabilistic. Quarto is not.

- Ask agents for the source, let Quarto render the artifact.
- Turns out this is also cheaper - generating a qmd uses WAY less tokens

---

## Act 3 — More importantly, it's much more likely to yield *correct* results when working with data

- Embarrassing Africa map

---

## Act 4 — Scaling to bigger artifacts: data websites

- vehicletrends.us — real, multi-page, self-updating Quarto site over 10M+
  vehicle listings.
- Agent never touched the data — it lives in an R package the
  pages read at render, so every number has an address and nothing goes stale.
- "But why not just build a Shiny app?"** — Shiny is fine and it's still source, but Shiny makes you to *assemble the artifact* (UI + inputs + outputs + server + reactivity) and then run a server to hold it up.
- Quarto: markdown + a chunk returning a widget the browser runs, no server.
- **Small pieces have small context windows** — Isolation is the efficiency argument made architectural. The whole site is never in scope at once, so every interaction stays cheap and every component stays individually correct.
- **Put the hard thing in a box.** The MapLibre/PMTiles map is a separate repo,
  iterated alone, dropped in via a 6-line iframe.
- **It's just static files.** Charts, map, even the Shiny app (Shinylive → WASM) all run client-side. No server to run, secure, or pay for.

---

## Act 5 — You also get trust

HTML can't tell you it's broken. A `.qmd` has a compile step

- "Why not just ask for HTML?" Agents are very good at it.
- HTML is genuinely great for isolated subcomponents (e.g., PMTiles map).
- But malformed HTML still renders as *something*, so the agent can't tell
  whether it succeeded.
- A bad chunk or cross-reference in a `.qmd` is a loud,
  deterministic error the agent reads and fixes without me.
  (Rhymes with Africa map: *that map rendered fine too.*)
- **Checkable twice:** by machine (`quarto render`) and by human (plain text → the edit is a diff; review scales with the change, not the document).

---

## Act 6 — Close with recommendations

You don't need to know Quarto to start. Change one word - **Ask for the `.qmd`.**

- Put *"always run `quarto render` before finishing"* in `CLAUDE.md`
- Have the agent work on a branch so edits arrive as diffs;
- keep data in files the `.qmd` reads, never in the prompt.
