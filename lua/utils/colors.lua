-- Convert "#rrggbb" to r,g,b (0-255)
local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16),
         tonumber(hex:sub(3, 4), 16),
         tonumber(hex:sub(5, 6), 16)
end
-- Convert r,g,b (0-255) to "#rrggbb"
local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end
-- Linear interpolation between two numbers
local function lerp(a, b, t)
  return a + (b - a) * t
end

-- Generate a gradient between two hex colors.
-- Returns a table of hex strings: { "#rrggbb", ... }
local function generate_gradient(start_hex, end_hex, steps)
  local sr, sg, sb = hex_to_rgb(start_hex)
  local er, eg, eb = hex_to_rgb(end_hex)
  local colors = {}
  if steps <= 1 then
    return { start_hex }
  end
  for i = 0, steps - 1 do
    local t = i / (steps - 1)
    local r = math.floor(lerp(sr, er, t) + 0.5)
    local g = math.floor(lerp(sg, eg, t) + 0.5)
    local b = math.floor(lerp(sb, eb, t) + 0.5)
    colors[#colors + 1] = rgb_to_hex(r, g, b)
  end
  return colors
end

-- Optional: create highlight groups for the gradient.
-- Example: prefix = "StartLogo" -> "StartLogo1", "StartLogo2", ...
local function create_gradient_highlights(start_hex, end_hex, steps, prefix)
  local colors = generate_gradient(start_hex, end_hex, steps)
  prefix = prefix or "Grad"
  for i, color in ipairs(colors) do
    local group = string.format("%s%d", prefix, i)
    vim.api.nvim_set_hl(0, group, { fg = color })
  end
  return colors
end

local function int_to_hex(color)
  if not color then
    return nil
  end
  return string.format("#%06x", color)
end

local function get_background_color()
  -- `link = false` so it resolves links, not just returns the link target name
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
  if not ok or not hl or not hl.bg then
    return nil
  end
  -- return hl.bg  -- integer, e.g. 0x1e1e2
  return int_to_hex(hl.bg)
end


local function get_theme_palette()

-- these are taken from https://github.com/morhetz/gruvbox
    local pal = {}
    pal.dark_red = "#cc241d"
    pal.dark_green = "#98971a"
    pal.dark_yellow = "$d79921"
    pal.dark_blue = "#458588"
    pal.dark_purple = "#b16286"
    pal.dark_aqua = "#689d6a"
    pal.bright_red = "#fb4934"
    pal.bright_green = "#b8bb26"
    pal.bright_yellow = "#fabd2f"
    pal.bright_blue = "#83a598"
    pal.bright_purple = "#d3869b"
    pal.bright_aqua = "8ec07c"
    pal.dark_orange = "#d65d0e"
    pal.bright_orange = "#fe8019"
    return pal

end


return {
    generate_gradient = generate_gradient,
    create_gradient_highlights = create_gradient_highlights,
    get_background_color = get_background_color,
    get_theme_palette = get_theme_palette,
}
