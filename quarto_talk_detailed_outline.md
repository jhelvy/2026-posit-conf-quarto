# The Unreasonable Effectiveness of Quarto — Talk Outline

## Core narrative

The talk should not be framed as a tour of Quarto features or as a generic "AI + dashboards" talk. The central story is:

> AI generates artifacts probabilistically, while Quarto gives us a source/render boundary that lets us retain control over those artifacts.

The narrative arc is:

**Problem → idea → application → proof → payoff**

More specifically:

**AI-generated artifact problem**
→ **content and format become entangled**
→ **ask the agent for the source instead**
→ **Quarto separates source from rendered artifact**
→ **this becomes especially powerful for dashboards**
→ **dashboard decomposition reduces AI context requirements**
→ **static/client-side architecture reduces application complexity**
→ **the same architecture reduces token cost**
→ **deterministic rendering provides a correctness check**
→ **return to the dashboard and show that the whole thing is a composition of small, understandable pieces**

The three major benefits should ultimately be framed as:

**Control → Cost → Correctness**

These are already a strong organizing spine in the existing deck and should remain intact.

---

# Act 1 — The problem

## 1. Title

### Purpose
Open with the title and establish the broad promise of the talk.

### Content
"The Unreasonable Effectiveness of Quarto."

Do not explain the thesis yet. Let the audience wonder what makes Quarto "unreasonably effective."

---

## 2. Vehicletrends dashboard

### Purpose
Establish the kind of thing the speaker wants to build and give the audience a concrete visual target.

### Content
Show the existing vehicletrends dashboard / animation.

The point is not yet to explain how it works. It is simply:

> This is the kind of thing I love making with Quarto.

---

## 3. Quarto + AI

### Purpose
Introduce the new context: AI changes how these artifacts can be produced.

### Content
Introduce the idea that AI agents can now help build documents, websites, and dashboards.

Avoid claiming that AI cannot build dashboards. The more interesting issue is what happens when the AI owns the final artifact.

---

## 4. Epic Dashboards

### Purpose
Use the image as a playful promise and establish the destination.

### Content
"Epic Dashboards."

Pause here.

Then make the deliberate pivot:

> But before I show you how to build one, let's look at a much simpler problem.

---

## 5. Handwriting practice sheet

### Purpose
Introduce the central problem using an intuitive example that has nothing to do with dashboards.

### Content
Show the request to an AI to make a handwriting practice sheet.

The audience should understand immediately that this is a simple artifact-generation task.

---

## 6. Iteration / eight rounds

### Purpose
Show what happens when the AI owns both the content and the formatting.

### Content
Show the progression from the initial result to the eventual result after repeated prompting.

The important observation is not that the AI is "bad at formatting."

Instead:

> Every time the artifact is regenerated, both the content and the format are potentially being regenerated.

---

## 7. Content and format entanglement

### Purpose
Abstract the handwriting example into the general problem.

### Content
Show the content/format entanglement diagram.

The key sentence:

> I wanted these words in this layout.

The deeper point:

> The problem is not that the AI cannot make the document; the problem is that the AI is being asked to regenerate the entire artifact when only one part needs to change.

This is the first major conceptual moment of the talk.

---

## 8. Quarto disentangles content and format

### Purpose
Introduce Quarto as the architectural answer rather than as a software feature.

### Content
Show the source/render distinction.

The central idea:

> Quarto moves the boundary between source and artifact to a place where we can control it.

---

## 9. Ask for the source, not the artifact

### Purpose
State the key principle that will drive the rest of the talk.

### Content
Use:

> Ask for the `.qmd`, not the artifact.

Explain that the AI can write the source/structure while Quarto handles deterministic rendering.

This should be treated as one of the thesis statements of the talk.

---

# Act 2 — Why this matters for dashboards

The dashboard section should come **before** the cost and correctness sections.

The reason is narrative: after the audience understands the source/artifact distinction, immediately show why this matters for the dashboard they saw at the beginning. Cost and correctness then become evidence of the benefits rather than a long detour before the audience gets back to dashboards.

The dashboard section should NOT become a list of Quarto features.

Instead, organize it around one larger idea:

> A Quarto dashboard can be decomposed into small, independently understandable pieces.

That decomposition is especially powerful when an AI agent is building or modifying the site.

---

## 10. This is not a 3,000-line dashboard

### Purpose
Reframe the dashboard as a collection of small documents rather than one giant application.

### Content
Show the vehicletrends site structure and the fact that it consists of multiple `.qmd` pages.

Emphasize:

> This isn't one 3,000-line dashboard. It's a collection of small documents.

Connect this immediately to AI:

> That distinction matters when an agent is working on it.

---

## 11. Every page gets a URL

### Purpose
Explain one of the practical consequences of treating the dashboard as a website rather than a single application.

### Content
Show examples such as `/depreciation`.

Emphasize:

- individual pages can be linked
- pages can be bookmarked
- the back button works
- search engines can index pages
- multiple pages mean multiple addresses

The conceptual line:

> It's a dashboard that behaves like a website.

---

## 12. No UI. No server.

### Purpose
Explain the architectural simplicity of Quarto dashboards.

### Content
Contrast a traditional Shiny application with a Quarto document containing client-side widgets.

Shiny conceptually requires UI + server + reactive state + a running process.

Quarto can simply contain markdown and a widget.

The key line:

> This isn't an application. It's a document.

Avoid making this a broad anti-Shiny claim. The point is that many dashboard problems do not require a continuously running application server.

---

## 13. Small pieces have small context windows

### Purpose
Connect dashboard decomposition directly to AI.

### Content
Show that an agent can work on one page at a time rather than loading the whole site into context.

The existing framing is strong:

> The agent opens one page — 200 to 600 lines. Never the site.

The key conceptual point:

> The whole dashboard is never in scope at once.

This should be one of the strongest AI-specific points in the dashboard section.

---

## 14. Interactivity lives in the browser

### Purpose
Show that a dashboard can still be highly interactive without requiring a server.

### Content
Use a concrete ECharts / echarts4r / Plotly-style example.

Show that the document can contain a widget whose interaction is handled by JavaScript in the browser.

The point is not "Quarto supports JavaScript."

The point is:

> I can put an interactive widget in a document without building the application around it.

---

## 15. Document layout comes for free

### Purpose
Show that the dashboard gets useful navigation and layout primitives from the document system itself.

### Content
Briefly show things such as:

- tabs
- table of contents
- columns
- sidebar/navigation
- sections

Do not spend much time on individual features.

The conceptual line:

> Because it's a document, I don't have to build the dashboard's navigation system from scratch.

---

## 16. Have a heavier artifact? Put it in a box.

### Purpose
Demonstrate the compositional architecture with the most concrete example.

### Content
Show the census-tract map / iframe example.

Explain that the hardest artifact on the site can live in its own repository/project and simply be embedded into the dashboard.

The key line:

> Quarto doesn't need to be the thing that does everything. It needs to be the thing that composes everything.

This is a particularly strong example because the map can be developed independently and the dashboard does not need to understand its implementation.

---

## 17. It's just static files

### Purpose
Pull together the client-side/static architecture.

### Content
Explain that the final site can be a collection of HTML, JavaScript, assets, and other files served directly to the browser.

Then mention the practical consequences:

- GitHub Pages
- Netlify
- inexpensive/free hosting
- no server to run
- no server to secure
- no server to pay for

Prefer "static files" or "runs in the browser" over making "serverless" the central term.

---

## 18. Dashboard section synthesis

### Purpose
State the architectural insight before moving to the quantitative/technical evidence.

### Content
Something like:

> Quarto lets me compose a dashboard out of things that don't need to understand each other.

Then connect explicitly to AI:

> And that turns out to be really useful when one of the things building it is an AI.

This is the bridge into Cost.

---

# Act 3 — Cost

## 19. Control → Cost → Correctness

### Purpose
Reintroduce the three-part spine and signal that the next two sections are evidence for the architecture.

### Content
Show the existing Control → Cost → Correctness progression, with Control already earned from the handwriting/source discussion and Cost becoming active.

Do not over-explain. The audience should recognize that the talk is moving through the consequences of the source/render architecture.

---

## 20. Token experiment

### Purpose
Quantify the cost advantage of asking the agent to write one source file rather than repeatedly generating finished artifacts.

### Content
Show the existing token experiment comparing multiple finished outputs with a single `.qmd` source rendered into outputs.

The key insight:

> If the source is the artifact the agent edits, we do not need the model to regenerate every representation of the document.

Tie this directly back to the dashboard section:

> The same decomposition that keeps the dashboard in a small context also keeps the token bill smaller.

---

## 21. One source, many outputs

### Purpose
Make the cost argument concrete and reinforce the broader source/artifact philosophy.

### Content
Show the existing `.qmd` → PDF/HTML/etc. relationship.

The point is:

> One probabilistic pass can produce a source; deterministic tooling can produce multiple artifacts.

This reinforces that the model should write the source, not independently regenerate every final format.

---

# Act 4 — Correctness

## 22. Bad Africa map

### Purpose
Introduce the most consequential failure mode: an artifact that looks plausible but is factually wrong.

### Content
Show the bad map.

The key line:

> This map has no failure mode.

The point is that a generative model can produce something visually convincing without having a deterministic mechanism that checks the underlying relationship.

---

## 23. Same map from source

### Purpose
Show that the source representation gives us something inspectable and reproducible.

### Content
Show the source code alongside the correctly rendered map.

The audience should see the connection between source, data, and output.

---

## 24. Quarto is checkable twice

### Purpose
Make the correctness argument explicit.

### Content
Show the two forms of checking:

**By machine**
- `quarto render` is a compile step
- code/data assertions can fail the render

**By human**
- plain text source can be reviewed as a diff

The key conceptual point:

> The source can be checked before the artifact is trusted, and the render can be checked by the machine.

---

# Act 5 — Return to dashboards

This final dashboard section should be the payoff, not another feature tour.

## 25. Back to the dashboard

### Purpose
Return to the visual introduced at the beginning and let the audience reinterpret it.

### Content
Show the vehicletrends dashboard again.

Say, in effect:

> Now let's look at that dashboard again.

---

## 26. Peel apart the dashboard

### Purpose
Reveal that what looked like one complicated application is actually a composition of simple pieces.

### Content
Walk through:

- each page is a `.qmd`
- data lives separately
- charts are widgets
- navigation comes from Quarto
- heavy artifacts can be embedded
- the browser handles client-side interaction
- there is no need for the whole site to be in the agent's context

This is where the earlier dashboard examples pay off.

---

## 27. The dashboard architecture

### Purpose
Give the audience the final mental model.

### Content
Show a simple architecture diagram:

**Agent**
→ writes/edits **small `.qmd` sources**

**Quarto**
→ renders the site

**Data / packages**
→ provide the underlying data

**JavaScript widgets / external artifacts**
→ provide specialized interactivity

**Browser**
→ displays and handles client-side interaction

The point:

> No single component needs to understand the whole system.

---

## 28. Agents should write the source, not the artifact

### Purpose
State the final principle.

### Content
Use:

> Agents should write the source, not the artifact.

Then connect it back to the entire talk:

- source preserves control
- source reduces context
- source reduces repeated generation
- source can be checked
- Quarto turns source into deterministic artifacts

---

## 29. Close

### Purpose
End on the broader claim rather than on a list of Quarto features.

### Content
Return to the title:

> The Unreasonable Effectiveness of Quarto

Then the final thought should be approximately:

> Software solved the source/artifact problem decades ago. Documents are only getting there now — right when the authors became probabilistic.

The final message is not "Quarto has great dashboard features."

It is:

> Quarto is unusually effective in the age of AI because it gives probabilistic agents a clean source to write and a deterministic system to render and check.
