--[[
lexis-shortcodes.lua — slide-modifier shortcodes for the Lexis reveal.js theme.

John authors slides the xaringan way: `---` starts every slide and headings are
just text (this format sets `slide-level: 0`). That leaves a `---`-delimited
slide with no heading to hang slide attributes on. These shortcodes stand in for
xaringan's `class:`/`background-*` lines written after a `---`:

    {{< inverse >}}                     dark slide (light text, orange code)
    {{< center >}}                      center content horizontally
    {{< middle >}}                      center content vertically
    {{< bg-color "#909099" >}}          full-slide background color
    {{< bg-image "images/x.jpg" >}}     full-slide background image
                                        (size / position / repeat / opacity)
    {{< no-slide-number >}}             hide the slide number on this slide

Each emits an invisible marker span. The companion filter `lexis.lua` (running
post-quarto, after shortcodes expand) collects the markers in each slide region
and hoists them onto the slide's <section>. See lexis.lua for the mechanism.

Markers encode their intent so the filter needs no per-name knowledge:
  * class  X  ->  span class `lexis-class-X`   (added to the <section>)
  * attr   K  ->  span attribute `lexis-<K>`   (mapped to a section attribute)
All markers also carry the class `lexis-mod` so the filter can find them.
--]]

-- A marker that adds one or more CSS classes to the enclosing slide.
local function class_marker(...)
  local classes = pandoc.List({ "lexis-mod" })
  for _, name in ipairs({ ... }) do
    classes:insert("lexis-class-" .. name)
  end
  return pandoc.Span({}, pandoc.Attr("", classes, {}))
end

-- A marker that carries background/state attributes for the enclosing slide.
local function attr_marker(attrs)
  return pandoc.Span({}, pandoc.Attr("", { "lexis-mod" }, attrs))
end

local function arg(args, i)
  return args[i] and pandoc.utils.stringify(args[i]) or nil
end

-- Reveal's background knobs, all optional and all passed straight through as
-- `lexis-bg-<name>` (see collect() in lexis.lua). Reveal's own default is
-- `size=cover`: the image fills the slide and overflow is cropped. The others:
--
--   size="contain"      whole image visible, letterboxed — pair with
--                       {{< bg-color >}} to choose the color of the bars
--   size="100% 100%"    stretch to fit, aspect ratio not preserved
--   position="top left" where a cropped/contained image sits
--   repeat="repeat"     tile it (reveal defaults to no-repeat)
--   opacity=0.4         dim the image so text on top stays readable
local BG_IMAGE_OPTS = { "size", "position", "repeat", "opacity" }

return {
  ["inverse"] = function(args, kwargs, meta) return class_marker("inverse") end,
  ["center"]  = function(args, kwargs, meta) return class_marker("center") end,
  ["middle"]  = function(args, kwargs, meta) return class_marker("middle") end,
  ["tight"]   = function(args, kwargs, meta) return class_marker("tight") end,

  ["bg-color"] = function(args, kwargs, meta)
    return attr_marker({ ["lexis-bg-color"] = arg(args, 1) or "" })
  end,

  ["bg-image"] = function(args, kwargs, meta)
    local attrs = { ["lexis-bg-image"] = arg(args, 1) or "" }
    for _, k in ipairs(BG_IMAGE_OPTS) do
      local v = kwargs[k] and pandoc.utils.stringify(kwargs[k])
      if v and #v > 0 then attrs["lexis-bg-" .. k] = v end
    end
    return attr_marker(attrs)
  end,

  ["no-slide-number"] = function(args, kwargs, meta)
    return attr_marker({ ["lexis-state"] = "no-slide-number" })
  end,
}
