--[[
lexis.lua — slide-modifier collector for the Lexis reveal.js theme.

THE PROBLEM
  This format uses `slide-level: 0` (John's xaringan paradigm): only `---`
  starts a slide and every heading is just styled text within a slide. But
  reveal slide modifiers — inverse, center, middle, background color/image — are
  normally attributes on the slide's *heading* (`## T {.inverse bg=...}`). With
  no heading owning the slide there is nowhere to write them, and Pandoc's reveal
  writer emits a bare `<section class="slide level0">`.

THE MECHANISM (verified empirically)
  Slides are formed by the reveal writer, after all filters run, by splitting the
  block stream on `HorizontalRule` (`---`). A writer-formed `---` slide has no
  attributes. Two facts make the fix work at the `post-quarto` phase (where the
  {{< inverse >}}/etc. shortcodes have already expanded into marker spans):

    1. If a single Div spans a whole slide, the writer consumes that Div to build
       the <section> and hoists the Div's classes/attributes onto it, mapping
       `background-color`/`background-image` to `data-background-color`/
       `data-background-image` exactly as it would from a heading.
    2. BUT if the Div sits *inside* a still-present `---` boundary, the writer
       makes it a nested (vertical) slide — an empty parent <section> wrapping
       ours. So we must OWN the boundaries: consume every `HorizontalRule` and
       re-emit each slide region as one top-level Div. The writer then turns each
       Div into exactly one flat slide, attributes and all.

  So this filter:
    * splits the document's top-level blocks into `---`-delimited regions,
    * collects + strips every `lexis-mod` marker in a region,
    * wraps each region in a single Div carrying the accumulated classes /
      background attributes (a bare Div for unmodified slides),
    * emits the Divs with NO `HorizontalRule` between them.

  Marker encoding (see lexis-shortcodes.lua):
    class `lexis-class-X`      -> add class X to the <section>
    attr  `lexis-bg-color`     -> background-color      (-> data-background-color)
    attr  `lexis-bg-image`     -> background-image      (-> data-background-image)
    attr  `lexis-bg-size`      -> background-size
    attr  `lexis-bg-position`  -> background-position
    attr  `lexis-state`        -> data-state (reveal mirrors this onto `.reveal`
                                  while the slide is active; used e.g. to hide
                                  the slide number)
--]]

local INVERSE_BG = "#121212"

-- At slide-level 0 a *top-level* heading is just styled text, but a heading
-- nested inside a fenced Div (e.g. `::: {.leftcol}`) makes Pandoc's reveal
-- writer promote that Div to its own `<section>`, shattering the slide. Since
-- this theme's whole premise is "headings are just text sizes," we rewrite any
-- Div-nested heading into a `.h1`..`.h6` styled Div so it looks like a heading
-- without ever becoming a slide. Panel-tabset headings are left alone — the
-- tabset needs them to name its tabs.
local HN = { "h1", "h2", "h3", "h4", "h5", "h6" }
local function demote(blocks, active)
  local out = pandoc.List({})
  for _, b in ipairs(blocks) do
    if b.t == "Header" and active then
      local cls = pandoc.List({ HN[b.level] or "h6" })
      cls:extend(b.classes)
      out:insert(pandoc.Div({ pandoc.Plain(b.content) },
        pandoc.Attr(b.identifier, cls, b.attributes)))
    elseif b.t == "Div" then
      local inside = not b.classes:includes("panel-tabset")
      out:insert(pandoc.Div(demote(b.content, inside), b.attr))
    else
      out:insert(b)
    end
  end
  return out
end

-- Column layout: `::: {.col width="60%" gap="2em" valign="middle"}`. Any run
-- of 2+ consecutive `.col` Divs (at any nesting level) is wrapped in a
-- `.cols-row` flex container; `width` becomes that column's flex-basis (a
-- lone `.col` with no run partner is left alone — no wrapper needed). `gap`/
-- `valign` are per-run settings, so they're read off whichever `.col` in the
-- run happens to carry them and hoisted onto the wrapper. Recurses into every
-- Div's content first so columns nested inside e.g. a panel-tabset tab, or a
-- column itself, are grouped too.
local VALIGN = { top = "flex-start", middle = "center", bottom = "flex-end" }
local function group_cols(blocks)
  local out = pandoc.List({})
  local run = pandoc.List({})
  local run_gap, run_valign

  local function flush()
    if #run == 0 then return end
    if #run == 1 then
      out:insert(run[1])
    else
      local style = ""
      if run_gap then style = style .. "gap:" .. run_gap .. ";" end
      if run_valign then
        style = style .. "align-items:" .. (VALIGN[run_valign] or run_valign) .. ";"
      end
      local wrap_attrs = {}
      if #style > 0 then wrap_attrs["style"] = style end
      out:insert(pandoc.Div(run, pandoc.Attr("", { "cols-row" }, wrap_attrs)))
    end
    run, run_gap, run_valign = pandoc.List({}), nil, nil
  end

  for _, b in ipairs(blocks) do
    if b.t == "Div" then
      b = pandoc.Div(group_cols(b.content), b.attr)
    end
    if b.t == "Div" and b.classes:includes("col") then
      local width = b.attributes["width"]
      local gap = b.attributes["gap"]
      local valign = b.attributes["valign"]
      local attrs = {}
      for k, v in pairs(b.attributes) do
        if k ~= "width" and k ~= "gap" and k ~= "valign" then attrs[k] = v end
      end
      if width then
        -- `flex-basis` sizes it correctly inside a `.cols-row`; `width` makes
        -- the same attribute do the right thing on a lone `.col` too (one
        -- used by itself, with no run partner, to just narrow a block).
        attrs["style"] = (attrs["style"] and (attrs["style"] .. ";") or "")
          .. "flex:0 1 " .. width .. ";width:" .. width
      end
      run:insert(pandoc.Div(b.content, pandoc.Attr(b.identifier, b.classes, attrs)))
      if gap then run_gap = gap end
      if valign then run_valign = valign end
    else
      flush()
      out:insert(b)
    end
  end
  flush()
  return out
end

-- Quarto appends housekeeping Divs after the last slide (footnotes/refs, hidden
-- content). They must stay at the top level, never folded into a slide.
local SKIP_CLASSES = {
  ["hidden"] = true,
  ["quarto-auto-generated-content"] = true,
  ["refs"] = true,
}
local function is_skip(block)
  if block.t ~= "Div" then return false end
  for _, c in ipairs(block.classes) do
    if SKIP_CLASSES[c] then return true end
  end
  return false
end

-- Collect + strip every marker inside one slide region. Returns the cleaned
-- blocks, the classes to add, the section attributes, and a lookup of which
-- named classes were seen (so callers can react, e.g. inverse -> dark bg).
local function collect(blocks)
  local classes = pandoc.List({})
  local attrs = {}
  local seen = {}

  local function take(el)
    if not el.classes:includes("lexis-mod") then return nil end
    for _, c in ipairs(el.classes) do
      local name = c:match("^lexis%-class%-(.+)$")
      if name and not seen[name] then
        classes:insert(name)
        seen[name] = true
      end
    end
    for k, v in pairs(el.attributes) do
      if k == "lexis-bg-color" then
        if #v > 0 then attrs["background-color"] = v end
      elseif k == "lexis-bg-image" then
        if #v > 0 then attrs["background-image"] = v end
      elseif k == "lexis-bg-size" then
        attrs["background-size"] = v
      elseif k == "lexis-bg-position" then
        attrs["background-position"] = v
      elseif k == "lexis-state" then
        attrs["data-state"] = attrs["data-state"]
          and (attrs["data-state"] .. " " .. v) or v
      end
    end
    return {} -- drop the marker
  end

  local walked = pandoc.walk_block(pandoc.Div(blocks), {
    Span = take,
    Div = take,
  })

  -- Markers usually sit alone on their own line; once stripped, drop the now
  -- empty/whitespace-only wrapper paragraph so it leaves no blank gap. BUT a
  -- paragraph can stringify to "" and still be visible: an image with empty alt
  -- text (`![](img.png)`) or a raw inline (`<img ...>`). stringify only sees
  -- TEXT, so guard against dropping those — otherwise a bare top-level image
  -- silently vanishes from the slide.
  local cleaned = pandoc.List({})
  for _, b in ipairs(walked.content) do
    local blank = (b.t == "Para" or b.t == "Plain")
      and #pandoc.utils.stringify(b):gsub("%s", "") == 0
    if blank then
      pandoc.walk_block(b, {
        Image     = function() blank = false end,
        RawInline = function() blank = false end,
      })
    end
    if not blank then cleaned:insert(b) end
  end

  return cleaned, classes, attrs, seen
end

-- `footer-align: center` (or `left`/`right`) in the document's YAML sets how
-- the `.footer` bar's text is aligned. lexis.scss reads a CSS custom
-- property (`--lexis-footer-align`, default `left`) rather than a fixed
-- value so this can be a per-document YAML key instead of a theme edit.
local FOOTER_ALIGN_VALUES = { left = true, center = true, right = true }
local function apply_footer_align(meta)
  local align = meta["footer-align"] and pandoc.utils.stringify(meta["footer-align"])
  if align and FOOTER_ALIGN_VALUES[align] then
    local vars = "--lexis-footer-align:" .. align .. ";"
    -- the bar's default 15px left inset reads fine for left/right alignment
    -- but visibly off-centers `center`, so drop it in that case only.
    if align == "center" then vars = vars .. "--lexis-footer-pad:0;" end
    quarto.doc.include_text("in-header", "<style>:root{" .. vars .. "}</style>")
  end
end

-- Quarto's reveal writer always emits a `.footer-default` div — inside the
-- trailing `.quarto-auto-generated-content` housekeeping wrapper — and its
-- own JS always sets it to `display: block` unless a slide overrides it.
-- Our `.footer` CSS draws a solid black bar for that div regardless of
-- whether it has any text, so leaving `footer:` blank/omitted in the YAML
-- (rather than not setting it) still produced an empty black stripe. Strip
-- the div when it has no visible content so no bar renders at all.
local function strip_empty_footer(blocks)
  local out = pandoc.List({})
  for _, b in ipairs(blocks) do
    if b.t == "Div" and b.classes:includes("footer-default")
      and #pandoc.utils.stringify(pandoc.Pandoc(b.content)):gsub("%s", "") == 0 then
      -- drop it
    elseif b.t == "Div" then
      out:insert(pandoc.Div(strip_empty_footer(b.content), b.attr))
    else
      out:insert(b)
    end
  end
  return out
end

function Pandoc(doc)
  apply_footer_align(doc.meta)

  -- Split top-level blocks into `---`-delimited regions.
  local regions, cur = pandoc.List({}), pandoc.List({})
  for _, b in ipairs(doc.blocks) do
    if b.t == "HorizontalRule" then
      regions:insert(cur)
      cur = pandoc.List({})
    else
      cur:insert(b)
    end
  end
  regions:insert(cur)

  -- Peel Quarto's trailing housekeeping Divs off the final region so they are
  -- never wrapped into a slide.
  local trailing = pandoc.List({})
  local last = regions[#regions]
  while #last > 0 and is_skip(last[#last]) do
    trailing:insert(1, last:remove(#last))
  end

  -- Re-emit the regions, keeping a HorizontalRule between them: the rule is
  -- what tells the reveal writer each region is a *horizontal* slide (drop the
  -- rules and every region collapses into one vertical stack). Unmodified
  -- regions are emitted bare so the writer forms a clean flat slide from them.
  -- A modified region is wrapped in one Div carrying its classes/attrs; the
  -- writer renders that as the region's slide with the modifiers applied.
  local out = pandoc.List({})
  local emitted = false
  for _, region in ipairs(regions) do
    local blocks, classes, attrs, seen = collect(region)

    -- Skip regions with no visible content (a leading setup chunk with
    -- `include: false`, an HTML comment, a stray `---`) so they don't become
    -- blank slides.
    local visible = #pandoc.utils.stringify(pandoc.Pandoc(blocks)):gsub("%s", "") > 0
    if not visible then
      -- images/plots carry no stringify text but are still visible content
      pandoc.walk_block(pandoc.Div(blocks), { Image = function() visible = true end })
    end
    if visible then
      -- Group consecutive `.col` Divs into `.cols-row` flex containers.
      blocks = group_cols(blocks)
      -- Rewrite Div-nested headings to styled text so columns/panels that
      -- contain `#`-headings don't fracture into extra slides.
      blocks = demote(blocks, false)
      -- Inverse slides are styled as a dark CARD in lexis.scss (a `.slides`
      -- background keyed off `section.present.inverse`), NOT a reveal
      -- full-bleed background — that keeps the gray letterbox around the slide
      -- like the old xaringan deck. So the `.inverse` class alone carries the
      -- dark look; we deliberately do not set a `data-background-color` here.

      if emitted then out:insert(pandoc.HorizontalRule()) end
      if #classes > 0 or next(attrs) ~= nil then
        -- Only modified slides need a wrapper (to carry their class/attrs).
        -- The HorizontalRule keeps it a horizontal slide; the writer renders
        -- the wrapper as that slide's own one-item vertical stack — BUT only
        -- if the wrapper Div reduces to exactly one Header-led slide the same
        -- way its own header-based slide splitting would see it (verified
        -- empirically): the *first* block must be a Header, and there must be
        -- no second one at the same level (two would read as two slides and
        -- promotion is refused). A modified slide with no heading, or one
        -- that opens with something else first (a raw HTML comment, an
        -- image, a paragraph), would otherwise silently lose its background/
        -- class — the wrapper stays a powerless <div> nested inside a bare
        -- <section>. Guarantee a single leading Header so promotion always
        -- succeeds: reuse the slide's existing heading if it has one
        -- (moving whatever preceded it after it instead), or synthesize an
        -- empty one for a genuinely headerless slide.
        if not (blocks[1] and blocks[1].t == "Header") then
          local first_header
          for i, b in ipairs(blocks) do
            if b.t == "Header" then first_header = i break end
          end
          if first_header then
            local heading = blocks:remove(first_header)
            blocks:insert(1, heading)
          else
            blocks:insert(1, pandoc.Header(1, {}, pandoc.Attr("", { "lexis-slide-title" })))
          end
        end
        out:insert(pandoc.Div(blocks, pandoc.Attr("", classes, attrs)))
      else
        -- Plain slides stay bare so the writer forms a clean flat slide.
        out:extend(blocks)
      end
      emitted = true
    end
  end

  out:extend(strip_empty_footer(trailing))
  return pandoc.Pandoc(out, doc.meta)
end
