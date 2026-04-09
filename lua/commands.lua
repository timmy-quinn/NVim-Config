local function trim_start(s)
  return (s:gsub("^%s+", ""))
end

local function split_by_literal(s, sep)
  local out = {}
  local start = 1
  while true do
    local i, j = s:find(sep, start, true) -- plain (literal) find
    if not i then
      table.insert(out, s:sub(start))
      break
    end
    table.insert(out, s:sub(start, i - 1))
    start = j + 1
  end
  return out
end

local function align_by_sep(line1, line2, sep, min_gap)
  assert(sep and sep ~= "", "separator must be a non-empty string")
  min_gap = min_gap or 4

  local buf = 0
  local lines = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)

  local rows, maxw = {}, {}

  -- Parse + compute max widths per column
  for idx, line in ipairs(lines) do
    local indent = line:match("^%s*") or ""
    local rest = line:sub(#indent + 1)

    local parts = split_by_literal(rest, sep)
    for i, p in ipairs(parts) do
      parts[i] = trim_start(p)
      local w = vim.fn.strdisplaywidth(parts[i])
      maxw[i] = math.max(maxw[i] or 0, w)
    end

    rows[idx] = { indent = indent, parts = parts }
  end

  -- Rebuild: field + sep + padding (so next column starts aligned)
  for idx, row in ipairs(rows) do
    local out = { row.indent }
    local parts = row.parts

    for i = 1, #parts do
      local field = parts[i]
      local w = vim.fn.strdisplaywidth(field)

      if i < #parts then
        local pad = (maxw[i] or w) - w + min_gap
        table.insert(out, field .. sep .. string.rep(" ", pad))
      else
        table.insert(out, field)
      end
    end

    lines[idx] = table.concat(out)
  end

  vim.api.nvim_buf_set_lines(buf, line1 - 1, line2, false, lines)
end

vim.api.nvim_create_user_command("Align", function(opts)
  local sep = opts.fargs[1]
  local gap = tonumber(opts.fargs[2]) or 4
  align_by_sep(opts.line1, opts.line2, sep, gap)
end, { range = true, nargs = "+" }) -- requires at least 1 arg (the separator)




-- In your init.lua / plugin file
local cw = require("utils.cwrapper")

vim.api.nvim_create_user_command("WrapComments", function(opts)
  local width = tonumber(opts.args) or 80

  if opts.range == 0 then
    -- no selection: fall back to "current comment block" behavior
    cw.wrap_comments(width)
  else
    -- visual/explicit range: wrap only selected lines
    cw.wrap_comments_range(opts.line1 - 1, opts.line2 - 1, width)
  end
end, { nargs = "?", range = true })

-- normal mode: wrap comment block under cursor
vim.keymap.set("n", "<leader>cw", "<cmd>WrapComments<CR>", { silent = true })

-- visual mode: wrap only the selection
vim.keymap.set("x", "<leader>cw", ":WrapComments<CR>", { silent = true })


