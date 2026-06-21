# Title

The Unreasonable Effectiveness of Quarto

# Abstract

Quarto markets itself as a publishing framework. But at its core, Quarto is an abstraction layer separating *content* from *format* — a distinction that turns out to be remarkably powerful in the era of AI agents. When an LLM generates a document, content and structure emerge together in a single probabilistic pass, but nothing in that output is guaranteed. Quarto's code-at-render-time model solves this by letting the LLM build the structure while allowing the content that must be exact to be rendered deterministically from data files. The result is reproducible and auditable output that stays correct as your content changes, without needing to re-prompt models. This talk brings the agent + Quarto workflow to life with concrete examples, from a simple one-page PDF to a fully interactive multi-page dashboard integrating JavaScript libraries, Shinylive, and React, showing how asking an LLM for a qmd file instead of a finished document dramatically reduces token overhead while producing more dynamic, trustworthy, and maintainable output.

# Bio

John Paul (JP) is an Associate Professor at George Washington University in the Department of Engineering Management and Systems Engineering. His research focuses on understanding how consumer preferences, market dynamics, and policy affect the emergence and adoption of low-carbon technologies, such as electric vehicles and renewable energy technologies. He also studies the critical relationship between the US and China in developing and mass producing these technologies. He has expertise in exploratory data analysis, data visualization, reproducible workflows, choice modeling, conjoint analysis, survey design, interview-based research methods, the R programming language, China, and the global electric vehicle industry. He speaks fluent Mandarin Chinese and has conducted extensive fieldwork in China. John holds a Ph.D. and M.S. in Engineering and Public Policy from Carnegie Mellon University and a B.S. in Engineering Science and Mechanics (ESM) from Virginia Tech.
