
-- local on_exit = function(obj)
--   print(obj.code)
--   print(obj.signal)
--   print(obj.stdout)
--   print(obj.stderr)
-- end

-- -- Runs asynchronously:
-- vim.system({'jira', 'issue', 'list'}, { text = true }, on_exit)



-- Runs synchronously:
-- local obj = vim.system({'echo', 'hello'}, { text = true }):wait()
-- return{
--   "sbulav/jira-oil.nvim",
--   -- lazy=true,
  
--   config = function()
--     require("jira-oil").setup({
--       defaults = {
--         project = "PCA", -- or set JIRA_PROJECT env var
--       }
--     })
--   end
-- }
--
--
-- return {
--   'kid-icarus/jira.nvim',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-telescope/telescope.nvim', -- optional
--     -- 'folke/snacks.nvim', -- optional
--   },
--   opts = {}, -- see configuration section
-- }
--

-- return {
--     "letieu/jira.nvim",
--     config = require('jira').setup({
--         -- Jira settings
--         jira = {
--             api_version = "3",                          -- API version: "2" or "3" (default: "3")
--             limit = 200,                                -- Global limit of tasks per view (default: 200)
--             logging = false,                            -- Enable HTTP request/response logging (default: false)
--         },

--         active_sprint_query = "project = '%s' AND sprint in openSprints() ORDER BY Rank ASC",

--         -- Saved JQL queries for the JQL tab
--         -- Use %s as a placeholder for the project key
--         queries = {
--             ["Next sprint"] = "project = '%s' AND sprint in futureSprints() ORDER BY Rank ASC",
--             -- ["Backlog"] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done ORDER BY Rank ASC",
--             ["Backlog"] =  "project = PCA AND statusCategory != Done ORDER BY rank",
--             ["My Tasks"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
--         },

--         -- Project-specific overrides
--         -- Still think about this config, maybe not good enough
--         projects = {
--             ["PCA"] = {
--                 story_point_field = "customfield_10035",      -- Custom field ID for story points
--                 custom_fields = { -- Custom field to display in markdown view
--                     { key = "customfield_10016", label = "Acceptance Criteria" }
--                 },
--             }
--         }
--     })


--     -- opts = {
--     --     -- Your setup options...
--     --     jira = {
--     --         limit = 200,                                -- Global limit of tasks per view (default: 200)
--     --     },

--     -- },
-- }


return {}


