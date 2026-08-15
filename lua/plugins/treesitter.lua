return {
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate", 
        event = "BufRead",
        branch = "master",
        lazy = false,
        -- opts = {
        --       ensure_installed = { 
        --           "c", 
        --           "cpp",
        --           "rust",
        --           "lua",
        --           "vim",
        --           "vimdoc",
        --           "query",
        --           "markdown",
        --           "markdown_inline",
        --           "doxygen"
        --       },
        -- },
        config = function()
            require'nvim-treesitter.configs'.setup {
              -- A list of parser names, or "all" (the listed parsers MUST always be installed)
              ensure_installed = { 
                  "c", 
                  "cpp",
                  "rust",
                  "lua",
                  "vim",
                  "vimdoc",
                  "query",
                  "markdown",
                  "markdown_inline",
                  "doxygen"
              },

              -- Install parsers synchronously (only applied to `ensure_installed`)
              sync_install = false,

              -- Automatically install missing parsers when entering buffer
              -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
              auto_install = true,

              ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
              -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

              highlight = {
                enable = true,

                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- disable = {"c", "rust" },
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                -- disable = function(lang, buf)
                --     local max_filesize = 100 * 1024 -- 100 KB
                --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                --     if ok and stats and stats.size > max_filesize then
                --         return true
                --     end
                -- end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
              },
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = false,
                    },
                },
            }
        end
    }
    
    
}
--
--
-- modified version of code from this config
--https://github.com/fredrikaverpil/dotfiles/blob/main/nvim-fredrik/lua/fredrik/plugins/core/treesitter.lua
--return {
--  {
--    "nvim-treesitter/nvim-treesitter",
--    lazy = false,
--    event = "BufRead",
--    branch = "main",
--    build = ":TSUpdate",
--    ---@class TSConfig
--    opts = {
--      -- custom handling of parsers
--      ensure_installed = {
--        "astro",
--        "bash",
--        "c",
--        "css",
--        "diff",
--        "go",
--        "gomod",
--        "gowork",
--        "gosum",
--        "graphql",
--        "html",
--        "javascript",
--        "jsdoc",
--        "json",
--        "jsonc",
--        "json5",
--        "lua",
--        "luadoc",
--        "luap",
--        "markdown",
--        "markdown_inline",
--        "python",
--        "query",
--        "regex",
--        "toml",
--        "tsx",
--        "typescript",
--        "vim",
--        "vimdoc",
--        "yaml",
--        "ruby",
--      },
--    },
--    config = function(_, opts)
--      -- install parsers from custom opts.ensure_installed
--      if opts.ensure_installed and #opts.ensure_installed > 0 then
--        require("nvim-treesitter").install(opts.ensure_installed)
--        -- register and start parsers for filetypes
--        for _, parser in ipairs(opts.ensure_installed) do
--          local filetypes = parser -- In this case, parser is the filetype/language name
--          vim.treesitter.language.register(parser, filetypes)

--          vim.api.nvim_create_autocmd({ "FileType" }, {
--            pattern = filetypes,
--            callback = function(event)
--              vim.treesitter.start(event.buf, parser)
--            end,
--          })
--        end
--      end

--      -- -- Auto-install and start parsers for any buffer
--      -- vim.api.nvim_create_autocmd({ "BufRead" }, {
--      --   callback = function(event)
--      --     local bufnr = event.buf
--      --     local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

--      --     -- Skip if no filetype
--      --     if filetype == "" then
--      --       return
--      --     end

--      --     -- Check if this filetype is already handled by explicit opts.ensure_installed config
--      --     for _, filetypes in pairs(opts.ensure_installed) do
--      --       local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
--      --       if vim.tbl_contains(ft_table, filetype) then
--      --         return -- Already handled above
--      --       end
--      --     end

--      --     -- Get parser name based on filetype
--      --     local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
--      --     if not parser_name then
--      --       return
--      --     end
--      --     -- Try to get existing parser (helpful check if filetype was returned above)
--      --     local parser_configs = require("nvim-treesitter.parsers")
--      --     if not parser_configs[parser_name] then
--      --       return -- Parser not available, skip silently
--      --     end

--      --     local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

--      --     if not parser_installed then
--      --       -- If not installed, install parser synchronously
--      --       require("nvim-treesitter").install({ parser_name }):wait(30000)
--      --     end

--      --     -- let's check again
--      --     parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

--      --     if parser_installed then
--      --       -- Start treesitter for this buffer
--      --       vim.treesitter.start(bufnr, parser_name)
--      --     end
--      --   end,
--      -- })
--    end,
--  },
--  -- {
--  --   "nvim-treesitter/nvim-treesitter-context",
--  --   event = "BufRead",
--  --   dependencies = {
--  --     "nvim-treesitter/nvim-treesitter",
--  --     event = "BufRead",
--  --   },
--  --   opts = {
--  --     multiwindow = true,
--  --   },
--  -- },
--  --{
--  --  "nvim-treesitter/nvim-treesitter-textobjects",
--  --  branch = "main",
--  --  keys = {
--  --    {
--  --      "af",
--  --      function()
--  --        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
--  --      end,
--  --      desc = "Select outer function",
--  --      mode = { "x", "o" },
--  --    },
--  --    {
--  --      "if",
--  --      function()
--  --        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
--  --      end,
--  --      desc = "Select inner function",
--  --      mode = { "x", "o" },
--  --    },
--  --    {
--  --      "ac",
--  --      function()
--  --        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
--  --      end,
--  --      desc = "Select outer class",
--  --      mode = { "x", "o" },
--  --    },
--  --    {
--  --      "ic",
--  --      function()
--  --        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
--  --      end,
--  --      desc = "Select inner class",
--  --      mode = { "x", "o" },
--  --    },
--  --    {
--  --      "as",
--  --      function()
--  --        require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
--  --      end,
--  --      desc = "Select local scope",
--  --      mode = { "x", "o" },
--  --    },
--  --  },
--  --  ---@module "nvim-treesitter-textobjects"
--  --  opts = { multiwindow = true },
--  --},
--}
