local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Helper: get all lines from current buffer
local function get_buf_lines()
  return vim.api.nvim_buf_get_lines(0, 0, -1, false)
end

-- Helper: extract function "prototype" from a definition line
-- Example:
--   "static int foo(int x) {" -> "static int foo(int x);"
--   "static void bar(void)"  -> "static void bar(void);"
local function make_decl_from_line(line)
  -- Strip trailing spaces
  line = line:gsub("%s+$", "")

  -- Only consider lines with "static"
  if not line:match("%f[%w_]static%f[%W_]") then
    return nil
  end

  -- Very simple heuristic:
  --  1. Must contain '(' and ')'
  --  2. Must NOT end with ';' already (i.e. skip existing declarations)
  --  3. Treat everything from "static" up to ')' as the prototype
  if not (line:match("%(") and line:match("%)")) then
    return nil
  end

  if line:match(";%s*$") then
    -- already a declaration, skip
    return nil
  end

  -- Remove everything after the closing parenthesis
  local before_paren, rest = line:match("^(.-%))(%s*.*)$")
  if not before_paren then
    return nil
  end

  -- Ensure it starts at "static ...", just in case
  local static_start = before_paren:match("(static.*%))")
  if not static_start then
    return nil
  end

  return static_start .. ";"
end

local function generate_static_decls(_, _)
  local decls = {}
  for _, line in ipairs(get_buf_lines()) do
    local d = make_decl_from_line(line)
    if d then
      table.insert(decls, d)
    end
  end

  if #decls == 0 then
    return { "/* no static function definitions found */" }
  end

  return decls
end

local function get_comment_parts()
  local cs = vim.bo.commentstring or ""
  -- fallback if commentstring is empty or invalid
  if cs == "" or not cs:find("%%s") then
    -- a generic guess; you can tweak this default
    cs = "-- %s"
  end
  local before, after = cs:match("^(.*)%%s(.*)$")
  before = before or ""
  after  = after or ""
  return before, after
end



local function dfs_find_node_type(node, node_type)
  if node:type() == "identifier" then
    return node
  end
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    local found = dfs_find_node_type(child)
    if found then
      return found
    end
  end
  return nil
end

local function get_function_node(bufnr, line)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(bufnr, "c")
    local tree = parser:parse()[1]
    if tree == nil then return nil end
    local root = tree:root()
    -- Find the node at the start of the line
    local node = root:named_descendant_for_range(line, 0, line, 0)

    -- Ascend to function_definition
    while node and node:type() ~= "function_definition" and node:type() ~= "declaration" do
        node = node:parent()
    end
    return node
end


local function get_function_params(node, bufnr)
    if not node then return {} end
    -- Get the function_declarator node
    local declarator = node:field("declarator")[1]
    if not declarator or declarator:type() ~= "function_declarator" then return {} end

    -- Get the parameter_list node
    local parameters = declarator:field("parameters")[1]
    if not parameters or parameters:type() ~= "parameter_list" then return {} end

    local params = {}

    for param in parameters:iter_children() do
        if param:type() == "parameter_declaration" then

            -- If you want both the type and the declarator, you can do this 
            -- table.insert(params, vim.treesitter.get_node_text(param, bufnr))
            local identifier = dfs_find_node_type(param, "identifier")
            if identifier ~= nil then 
                table.insert(params, vim.treesitter.get_node_text(identifier, bufnr))
            end
            -- for p in param:iter_children() do 
            --     if p:type() == "identifier" then 
            --         table.insert(params, vim.treesitter.get_node_text(p, bufnr))
            --     end
            -- end

        end
    end
    return params
end

local function get_function_return(node, bufnr)
    if not node then return "" end
    local return_type = node:field("type")[1]
    if not return_type then return "" end
    if return_type:type() ~= "primitive_type" and return_type:type() ~= "type_identifier" then
        return ""
    end
    local rtn = vim.treesitter.get_node_text(return_type, bufnr)
    return rtn
end

local c_function = {
    params = {},
    return_type = "",
}

local function get_param_nodes(_, _)
    local nodes = {}
    local jump_index = 1
    for _, p in ipairs(c_function.params) do
        table.insert(nodes, t({"", " * @param " .. p .. " "}))
        table.insert(nodes, i(jump_index, "variable_description"))
        jump_index = jump_index + 1
    end
    if c_function.return_type ~= "void" and c_function.return_type ~= "" then
        table.insert(nodes, t{"", " * @return "})
        table.insert(nodes, i(jump_index, "return desciption"))
    end
    return sn(nil, nodes)
end


local function get_line_break()
    local cs = vim.bo.commentstring
    if not cs or cs == "" then 
        return ""
    end
    local comment_string = cs:gsub(" %%s", "")
    local rtn = ""
    for i = 1, (80 /string.len(comment_string)) do
        rtn = rtn .. comment_string
    end
    rtn = rtn
    return rtn
end



local fn_header = s({trig = ""}, {
    t({"/**", " * @brief "}),
    i(1, "Description"),
    d(2, get_param_nodes, {}),
    t({"", " */"})
})



--------------------------------------------------------------------------------
-- Python snippets
--------------------------------------------------------------------------------
-- Get function/class info from the line above the cursor
local function get_python_context()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  -- Look upward for the def/class line
  for lnum = row, math.max(row - 5, 1), -1 do
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""
    -- Match function
    local fname, params = line:match("^%s*def%s+([%w_]+)%s*%((.-)%)")
    if fname then
      return { type = "function", name = fname, params = params }
    end
    -- Match class
    local cname = line:match("^%s*class%s+([%w_]+)")
    if cname then
      return { type = "class", name = cname, params = nil }
    end
  end
  return nil
end

-- Parse param string into a list of names, stripping type hints and defaults
local function parse_params(params_str)
  if not params_str or params_str == "" then return {} end
  local result = {}
  for param in params_str:gmatch("[^,]+") do
    param = param:match("^%s*(.-)%s*$")  -- trim
    param = param:match("^([^:=]+)")     -- strip type hint / default
    param = param:match("^%s*(.-)%s*$")  -- trim again
    -- Skip self, cls, and */**args if you prefer (remove to keep them)
    if param ~= "self" and param ~= "cls"
      and not param:match("^%*") then
      table.insert(result, param)
    end
  end
  return result
end

-- Build the dynamic docstring node
local function docstring_node(_, parent)
  local ctx = get_python_context()
  local nodes = {}

  -- Summary line
  if ctx then
    local label = ctx.type == "class" and "Class" or "Function"
    table.insert(nodes, t({ '"""' .. label .. " " .. ctx.name .. "." }))
  else
    table.insert(nodes, t({ '"""' }))
  end

  table.insert(nodes, t({ "", "" }))
  -- Short description insert node
  table.insert(nodes, i(1, "Short description."))
  table.insert(nodes, t({ "", "" }))

  if ctx and ctx.type == "function" then
    local params = parse_params(ctx.params)
    if #params > 0 then
      table.insert(nodes, t({ "", "Args:" }))
      local idx = 2
      for _, param in ipairs(params) do
        table.insert(nodes, t({ "", "    " .. param .. " (" }))
        table.insert(nodes, i(idx, "type"))
        idx = idx + 1
        table.insert(nodes, t("): "))
        table.insert(nodes, i(idx, "Description."))
        idx = idx + 1
      end
      table.insert(nodes, t({ "", "" }))
    end

    -- Returns section
    table.insert(nodes, t({ "", "Returns:" }))
    table.insert(nodes, t({ "", "    " }))
    table.insert(nodes, i(#nodes, "Description of return value."))

  elseif ctx and ctx.type == "class" then
    -- Attributes section for classes
    table.insert(nodes, t({ "", "Attributes:" }))
    table.insert(nodes, t({ "", "    " }))
    table.insert(nodes, i(2, "attr (type): Description."))
  end

  table.insert(nodes, t({ "", '"""' }))

  return sn(nil, nodes)
end


local function add_snippets()
    local ls = require("luasnip")

    ls.add_snippets("lua", {
    })

    ls.add_snippets(
        "c", {
            s("fileheader", {
                t({"/**", " * @file   "}),
                f(function() return vim.fn.expand("%:t") end, {}),
                t({"", " * @brief  "}), i(1, "File description"),
                t({"", " * @author Timmy Quinn"}),
                t({"", " * @date   "}), f(function() return os.date("%Y-%m-%d") end, {}),
                t({"", " */", ""}),
            }),
            s('for', {
                t("for(size_t i = 0; i < "), i(1, "MAX"), t({"; i++) {", "", "}"})
            }),
            s("static_declarations", {
                t("/* static function declarations */"),
                t({ "", "" }),
                f(generate_static_decls, {}),
            }),

        }

    )

    ls.add_snippets("python", {
        s("docstring", {
            d(1, docstring_node),
        }),
    })

    -- The function header comment has to be triggered 
    vim.keymap.set({"i"}, "<C-Y>", function()
        local line = vim.fn.line('.')
        local node = get_function_node(0, line)
        c_function.params = get_function_params(node, 0)
        c_function.return_type = get_function_return(node, 0)
        ls.snip_expand(fn_header, {})
    end, {})

    ls.add_snippets(
        "all", {
            s('line_brk', {
                f(get_line_break, {}),
                t({""}),
            }),
            s({trig = "chead (.*)", regTrig=true, dsc = "Generate a centered header comment. Type in 'chead ' followed by the desired comment, then press <C-S>, or current luasnip expand keybinding"}, {
                f(function(_, snip)
                    local comment = vim.bo.commentstring or "//"
                    local before, after = get_comment_parts()
                    local text = snip.captures[1] or ""
                    local total_len = 80
                    local text_len = #text
                    local padding = " "
                    local pad_len = total_len - #before - #after - (#padding * 2) - text_len
                    local left = math.floor(pad_len / 2)
                    local right = pad_len - left
                    return before .. string.rep("*", left) .. padding .. text .. padding .. string.rep("*", right) .. after
                end, {}),
            }),

            s({trig = "bigchead", dsc = "Generate a block header comment."}, { 
                f(get_line_break, {}),
                f(function()
                    local before, _ = get_comment_parts()
                    return {"", before} -- add a new line 
                end, {}),
                i(1, "comment"),
                f(function()
                    local _, after = get_comment_parts()
                    return {after, ""} -- add a new line
                end, {}),
                f(get_line_break, {}),
            }),
        }
    )

end


return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.4.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load() -- supposed to automatically reload on any change, don't know if it works

            vim.keymap.set({"i"}, "<C-S>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})

            add_snippets()

            -- Set .h files to use the c filetype
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
              pattern = "*.h",
              callback = function()
                vim.bo.filetype = "c"
              end,
            })
        end
    }
}
