local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

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



local fn_header = s({trig = ""}, {
    t({"/**", " *", " * @brief "}),
    i(1, "Description"),
    d(2, get_param_nodes, {}),
    t({"", " */"})
})

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
                    f(function()
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
                    end, {}),
                    t({""}),
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
            local ls = require("luasnip")
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
