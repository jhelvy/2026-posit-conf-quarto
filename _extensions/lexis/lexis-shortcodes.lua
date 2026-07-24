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

return {
  ["inverse"] = function(args, kwargs, meta) return class_marker("inverse") end,
  ["center"]  = function(args, kwargs, meta) return class_marker("center") end,
  ["middle"]  = function(args, kwargs, meta) return class_marker("middle") end,

  ["bg-color"] = function(args, kwargs, meta)
    return attr_marker({ ["lexis-bg-color"] = arg(args, 1) or "" })
  end,

  ["bg-image"] = function(args, kwargs, meta)
    local attrs = { ["lexis-bg-image"] = arg(args, 1) or "" }
    -- optional: {{< bg-image "x.jpg" size=contain position="top left" >}}
    if kwargs["size"] and #pandoc.utils.stringify(kwargs["size"]) > 0 then
      attrs["lexis-bg-size"] = pandoc.utils.stringify(kwargs["size"])
    end
    if kwargs["position"] and #pandoc.utils.stringify(kwargs["position"]) > 0 then
      attrs["lexis-bg-position"] = pandoc.utils.stringify(kwargs["position"])
    end
    return attr_marker(attrs)
  end,

  ["no-slide-number"] = function(args, kwargs, meta)
    return attr_marker({ ["lexis-state"] = "no-slide-number" })
  end,
}
