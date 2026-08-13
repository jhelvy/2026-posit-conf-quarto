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

# The cost slides colour each format by its identity — Quarto blue, amber PDF,
# red HTML, Word blue — matching `.qmdblue` / `.amber` / `.red` / `.wordblue` in
# custom.css. Only the Quarto blue is needed here; the other three reach this
# figure as icons, not as colour. Quarto's brand blue is #74aadb, which is 2.5:1
# on white, so a dot or a letter uses the darker twin.
qmd_blue <- "#3d7fb5"

# Font Awesome, so the y-axis row names can carry the same file icons the
# character-count slides and the experiment figure use. The extension ships the
# webfonts and the .ttf files register fine; nothing here is installed
# system-wide, so this is what makes them available to the plot. Rendering goes
# through `ragg::agg_png` below for the same reason — the default quartz device
# does not see a font registered this way.
fa_dir <- "_extensions/quarto-ext/fontawesome/assets/webfonts"
systemfonts::register_font(
  "FA Solid",
  plain = file.path(fa_dir, "fa-solid-900.ttf")
)
systemfonts::register_font(
  "FA Brands",
  plain = file.path(fa_dir, "FontAwesome6Brands-Regular-400.ttf")
)

# fig-tokens: output tokens, Quarto vs. direct format ------------------------
# Quarto blue = Quarto, red = direct format. The dumbbell's whole argument is
# one dot against the other, so colour here stays a TWO-level encoding. The row
# names carry a file ICON rather than the format's colour: colouring them put a
# blue `Word` label on the same row as the blue Quarto dot, which is exactly the
# confusion the two-level encoding exists to avoid. Icons are ink, like the
# text. The Quarto dot moved off the deck's format teal because this figure
# lands seconds after the cost slides, and that echo is the nearer one.

results <- read_csv("data/token_results.csv", show_col_types = FALSE)

# Markdown is dropped from BOTH figures. It was the control in the post — proof
# that .qmd is essentially markdown — but on a slide the .qmd line already says
# that, and the row spends space arguing a point the deck has made twice by now.
# Three formats, three rows, three multipliers.
tokens <- results |>
  filter(output_type != "markdown") |>
  select(output_type, format_type, output_tokens) |>
  mutate(
    output_type = factor(
      output_type,
      levels = c("word", "html", "pdf"),
      labels = c("Word", "HTML", "PDF")
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

# The row's file icon, drawn beside the tick label rather than folded into it.
# ggtext's `element_markdown()` does not resolve a font registered this way — a
# `font-family` span comes out as tofu — but `geom_text(family = )` does. So the
# glyph is a layer: `x = -Inf` parks it at the panel's left edge, `hjust` pushes
# it out into the margin in multiples of its own width, and `clip = "off"` plus
# the wider `plot.margin` are what let it show. Two layers because html5 is a
# Brands glyph and the file icons are Free Solid. Ink, like the text.
row_icons <- tibble(
  output_type = factor(
    c("Word", "HTML", "PDF"),
    levels = levels(tokens$output_type)
  ),
  glyph = c("\uf1c2", "\uf13b", "\uf1c1"),
  family = c("FA Solid", "FA Brands", "FA Solid")
)

fig_tokens <- tokens |>
  ggplot(aes(x = output_tokens, y = output_type, color = format_type)) +
  geom_line(aes(group = output_type), color = "grey70", linewidth = 1) +
  geom_point(size = 4) +
  geom_text(
    data = filter(row_icons, family == "FA Solid"),
    aes(x = -Inf, y = output_type, label = glyph),
    inherit.aes = FALSE,
    family = "FA Solid",
    hjust = 4.2,
    size = 5.5,
    color = ink
  ) +
  geom_text(
    data = filter(row_icons, family == "FA Brands"),
    aes(x = -Inf, y = output_type, label = glyph),
    inherit.aes = FALSE,
    family = "FA Brands",
    hjust = 4.2,
    size = 5.5,
    color = ink
  ) +
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
      "Quarto (.qmd)" = qmd_blue
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
      "<span style='color: ",
      qmd_blue,
      ";'>Quarto (.qmd)</span>",
      " vs. ",
      "<span style='color: ",
      minou["red"],
      ";'>Direct format</span>",
      " output tokens"
    )
  ) +
  coord_cartesian(clip = "off") +
  theme_minimal_vgrid(font_family = font, font_size = 16) +
  theme(
    legend.position = "none",
    panel.grid.major.x = element_line(color = "grey90"),
    panel.grid.minor = element_blank(),
    plot.title.position = "plot",
    plot.title = element_markdown(),
    axis.text.y = element_text(color = ink),
    plot.margin = margin(5.5, 5.5, 5.5, 26),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

ggsave(
  "images/fig-tokens.png",
  fig_tokens,
  width = 10,
  height = 4, # was 5 at four rows; three rows want less, or the dots drift apart
  dpi = 192, # knitr's default (96 x fig-retina 2), so this matches the post
  bg = "white",
  device = ragg::agg_png # sees the fonts registered above; quartz does not
)

# africa-map: the correctness slide's map ------------------------------------
# The plot itself lives in africa-map.R, alone, because that file is what the
# slide displays — the code column is `readLines()` of it, so the audience is
# reading the exact script that made the image beside it. Nothing may be added
# to that file that the slide shouldn't show, which is why the ggsave is here
# and the script only returns the plot.
ggsave(
  "images/africa-map.png",
  source("africa-map.R")$value,
  width = 6,
  height = 5.5,
  dpi = 192,
  bg = "white",
  device = ragg::agg_png
)
