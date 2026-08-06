# Figures for the deck. Run this to regenerate anything in images/ that is a
# plot; every other image in there is a screenshot or a PDF export and does not
# come from here.
#
# Ported from the token-efficiency post
# (jhelvy.com/blog/2026-05-12-quarto-optimal-claude-output). Data is a verbatim
# copy of that post's data/token_results.csv, so the numbers on the slide and the
# numbers in the post are the same numbers.

library(tidyverse)
library(cowplot)
library(ggtext)
library(ltc)
library(colorspace)

font <- "Fira Sans Condensed" # matches the lexis deck theme

# Deck palette ---------------------------------------------------------------
# ltc::ltc("minou"), the talk's palette. See the header of custom.css for what
# each color means and why this palette was picked; the roles are the same here
# as on the slides, so a plot never introduces a color the deck hasn't taught.
minou <- setNames(
  ltc("minou"),
  c("teal", "red", "yellow", "green", "navy", "grey")
)

ink <- unname(minou["navy"]) # the figure's ink, for anything that isn't coded

# minou's yellow and green are light — fine as fills behind dark text, but
# invisible as a dot or a letter on a white panel (1.9:1 and 2.5:1). Same ink
# variants custom.css defines, so a yellow here is the same yellow as a
# `[word]{.amber}` on a slide.
minou_ink <- c(yellow = "#A77400", green = "#4A6D5A")

# fig-tokens: output tokens, Quarto vs. direct format ------------------------
# teal = Quarto, red = direct format. 208 deg apart in hue, both dark enough to
# work as text on a white panel, and the good/costly reading comes for free.
# Teal is the deck's "format/structure" color, which is the right echo: Quarto
# is the thing that handles the format for you.

results <- read_csv("data/token_results.csv", show_col_types = FALSE)

tokens <- results |>
  select(output_type, format_type, output_tokens) |>
  mutate(
    output_type = factor(
      output_type,
      levels = c("word", "html", "pdf", "markdown"),
      labels = c("Word", "HTML", "PDF", "Markdown")
    ),
    format_type = factor(
      format_type,
      levels = c("direct", "quarto"),
      labels = c("Direct format", "Quarto (.qmd)")
    )
  )

# The punchline label: how many times more expensive the direct format was.
# Trailing ".0" is dropped so these read as "1x", "4x" rather than "1.0x".
multipliers <- tokens |>
  select(output_type, format_type, output_tokens) |>
  pivot_wider(names_from = format_type, values_from = output_tokens) |>
  rename(direct = `Direct format`, quarto = `Quarto (.qmd)`) |>
  mutate(
    ratio = round(direct / quarto, 1),
    label = paste0(sub("\\.0$", "", format(ratio, trim = TRUE)), "×")
  )

fig_tokens <- tokens |>
  ggplot(aes(x = output_tokens, y = output_type, color = format_type)) +
  geom_line(aes(group = output_type), color = "grey70", linewidth = 1) +
  geom_point(size = 4) +
  # The multiplier is the only annotation. Per-dot token counts were here too
  # and were cut: the axis already gives the magnitudes, and "7.2x" is the
  # sentence you actually say out loud.
  geom_text(
    data = multipliers,
    aes(x = direct, y = output_type, label = label),
    inherit.aes = FALSE,
    nudge_x = 190,
    hjust = 0,
    size = 5.5,
    fontface = "bold",
    family = font,
    color = ink
  ) +
  scale_color_manual(
    values = c(
      "Direct format" = unname(minou["red"]),
      "Quarto (.qmd)" = unname(minou["teal"])
    )
  ) +
  scale_x_continuous(
    labels = scales::comma,
    expand = expansion(mult = c(0.08, 0.14)) # right pad holds the multipliers
  ) +
  labs(
    x = "Output tokens",
    y = NULL,
    color = NULL,
    title = paste0(
      "<span style='color: ", minou["teal"], ";'>Quarto (.qmd)</span>",
      " vs. ",
      "<span style='color: ", minou["red"], ";'>Direct format</span>",
      " output tokens"
    )
  ) +
  theme_minimal_vgrid(font_family = font, font_size = 16) +
  theme(
    legend.position = "none",
    panel.grid.major.x = element_line(color = "grey90"),
    panel.grid.minor = element_blank(),
    plot.title.position = "plot",
    plot.title = element_markdown(),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

ggsave(
  "images/fig-tokens.png",
  fig_tokens,
  width = 10,
  height = 5,
  dpi = 192, # knitr's default (96 x fig-retina 2), so this matches the post
  bg = "white"
)
