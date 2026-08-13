local M = {}

-- Get comment prefix and optional suffix from 'commentstring'
local function get_comment_parts()
  local cs = vim.api.nvim_buf_get_option(0, "commentstring")
  -- commentstring is usually like "// %s" or "/* %s */"
  local pre, post = cs:match("^(.*)%%s(.*)$")
  pre = pre or ""
  post = post or ""

  -- Normalize whitespace around prefix/suffix
  pre = pre:gsub("%s+$", "")  -- trim trailing space
  post = post:gsub("^%s+", "") -- trim leading space

  return pre, post
end

-- Build a Lua pattern that matches the comment prefix at line start
local function build_prefix_pattern(pre)
  if pre == "" then
    return nil
  end
  -- Escape pattern magic characters
  local function escape_magic(s)
    return (s:gsub("([^%w])", "%%%1"))
  end
  local esc = escape_magic(pre)
  -- Allow optional whitespace before/after the prefix
  return "^%s*" .. esc .. "%s*"
end

-- Wrap text to given width (simple greedy wrap)
local function wrap_text(words, width)
  local lines = {}
  local line = ""

  for _, w in ipairs(words) do
    if line == "" then
      line = w
    elseif #line + 1 + #w <= width then
      line = line .. " " .. w
    else
      table.insert(lines, line)
      line = w
    end
  end
  if line ~= "" then
    table.insert(lines, line)
  end

  return lines
end

-- Main function to wrap comments in a given range
function M.wrap_comments_range(start_line, end_line, width)
  width = width or 80
  local bufnr = 0
  local pre, post = get_comment_parts()
  local prefix_pat = build_prefix_pattern(pre)

  if not prefix_pat then
    vim.notify("No commentstring prefix detected; aborting wrap", vim.log.levels.WARN)
    return
  end

  -- Collect comment text and remember indentation/prefix for each line
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)

  local comment_chunks = {}
  local indent = nil

  for _, l in ipairs(lines) do
    if l:match("^%s*$") then
      -- Treat blank lines as paragraph separators
      table.insert(comment_chunks, { blank = true })
    else
      local indent_spaces, rest = l:match("^(%s*)(.*)$")
      indent = indent or indent_spaces

      local after_prefix = rest:gsub(prefix_pat, "", 1)
      local text = after_prefix
      if post ~= "" then
        -- strip trailing suffix if present
        local post_pat = "%s*" .. post:gsub("([^%w])", "%%%1") .. "%s*$"
        text = text:gsub(post_pat, "")
      end

      table.insert(comment_chunks, {
        blank = false,
        indent = indent_spaces,
        text = vim.trim(text),
      })
    end
  end

  -- Flatten into paragraphs separated by blank entries
  local new_lines = {}
  local current_words = {}
  local current_indent = nil

  local function flush_paragraph()
    if #current_words == 0 then
      return
    end
    -- available width for text = width - indent - prefix - space(s) - suffix
    local indent_len = #(current_indent or "")
    local prefix_len = #pre > 0 and (#pre + 1) or 0   -- +1 for a space after prefix
    local suffix_len = #post > 0 and (#post + 1) or 0 -- +1 for a space before suffix
    local text_width = math.max(10, width - indent_len - prefix_len - suffix_len)

    local wrapped = wrap_text(current_words, text_width)
    for _, wl in ipairs(wrapped) do
      local line = (current_indent or "")
      if #pre > 0 then
        line = line .. pre .. " "
      end
      line = line .. wl
      if #post > 0 then
        line = line .. " " .. post
      end
      table.insert(new_lines, line)
    end
    current_words = {}
  end

  for _, chunk in ipairs(comment_chunks) do
    if chunk.blank then
      flush_paragraph()
      table.insert(new_lines, "") -- keep blank line
      current_indent = nil
    else
      if not current_indent then
        current_indent = chunk.indent
      end
      if chunk.text ~= "" then
        for w in chunk.text:gmatch("%S+") do
          table.insert(current_words, w)
        end
      else
        -- Empty comment line acts like a paragraph break
        flush_paragraph()
        table.insert(new_lines, (chunk.indent or "") .. (pre ~= "" and (pre .. " ") or ""))
        current_indent = nil
      end
    end
  end
  flush_paragraph()

  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false, new_lines)
end

-- Command wrapper: determines range based on mode
function M.wrap_comments(width)
  width = width or 80
  local mode = vim.fn.mode()
  local start_line, end_line

  if mode == "v" or mode == "V" or mode == "\22" then
    -- visual mode: use the visual selection
    local _, ls, _, _ = unpack(vim.fn.getpos("'<"))
    local _, le, _, _ = unpack(vim.fn.getpos("'>"))
    start_line = math.min(ls, le) - 1
    end_line   = math.max(ls, le) - 1
  else
    -- normal mode: operate on current line's contiguous comment block
    local cur = vim.api.nvim_win_get_cursor(0)[1] - 1
    local pre, _ = get_comment_parts()
    local prefix_pat = build_prefix_pattern(pre)
    if not prefix_pat then
      vim.notify("No commentstring prefix detected; aborting wrap", vim.log.levels.WARN)
      return
    end
    local bufnr = 0
    local total = vim.api.nvim_buf_line_count(bufnr)

    local function is_comment_line(idx)
      if idx < 0 or idx >= total then
        return false
      end
      local l = vim.api.nvim_buf_get_lines(bufnr, idx, idx + 1, false)[1]
      return l:match(prefix_pat) ~= nil
    end

    if not is_comment_line(cur) then
      vim.notify("Current line is not a comment; aborting wrap", vim.log.levels.WARN)
      return
    end

    start_line = cur
    end_line = cur
    while is_comment_line(start_line - 1) do
      start_line = start_line - 1
    end
    while is_comment_line(end_line + 1) do
      end_line = end_line + 1
    end
  end

  M.wrap_comments_range(start_line, end_line, width)
end

return M
