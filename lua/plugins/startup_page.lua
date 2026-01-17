local colors = require("utils.colors")
local hanna_blue = "#005eb8"
local background ="#1d2021"
local pallete = colors.get_theme_palette()

-- FIGLET SETUP 
-- (figlet is used for generating some of the ascii text shown below)
-- sudo apt install figlet
-- clone github.com/xero/figlet-fonts 
-- move the font files into usr/share/figlet/fonts/
-- run the appropriate commands
-- figlet -f /usr/share/figlet/fonts/3d.flf "NeoTim"
local tim_vim  = {
        [[  ██████████ ██             ██      ██ ██            ]],
        [[ ░░░░░██░░░ ░░             ░██     ░██░░             ]],
        [[     ░██     ██ ██████████ ░██     ░██ ██ ██████████  ]],
        [[     ░██    ░██░░██░░██░░██░░██    ██ ░██░░██░░██░░██ ]],
        [[     ░██    ░██ ░██ ░██ ░██ ░░██  ██  ░██ ░██ ░██ ░██ ]],
        [[     ░██    ░██ ░██ ░██ ░██  ░░████   ░██ ░██ ░██ ░██ ]],
        [[     ░██    ░██ ███ ░██ ░██   ░░██    ░██ ███ ░██ ░██ ]],
        [[     ░░     ░░ ░░░  ░░  ░░     ░░     ░░ ░░░  ░░  ░░  ]],
    }
        -- figlet -f ANSI\ Shadow "TIMVIM"

local tim_vim_shadow = {
        [[ ████████╗██╗███╗   ███╗██╗   ██╗██╗███╗   ███╗ ]],
        [[ ╚══██╔══╝██║████╗ ████║██║   ██║██║████╗ ████║ ]],
        [[    ██║   ██║██╔████╔██║██║   ██║██║██╔████╔██║ ]],
        [[    ██║   ██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[    ██║   ██║██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[    ╚═╝   ╚═╝╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
    }
-- This is not unforunately by figlet, I guess someone did this by hand
local neovim_cool = {
          [[                                                                     ]],
          [[       ████ ██████           █████      ██                     ]],
          [[      ███████████             █████                             ]],
          [[      █████████ ███████████████████ ███   ███████████   ]],
          [[     █████████  ███    █████████████ █████ ██████████████   ]],
          [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
          [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
          [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
        }

local hanna_logo = {
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
          [[┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ █████████████████ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃]],
}



local function lineColor(lines, start_color, end_color)
  local out = {}
  local prefix = "startup_header"
  -- gradient.create_gradient_highlights(hanna_blue,"#65a5ab", 21, prefix)
  colors.create_gradient_highlights(start_color,end_color, #lines, prefix)
  for i, line in ipairs(lines) do
    local hi = prefix .. i
    -- hi = "StartLogo" .. i
    table.insert(out, { hi = hi, line = line})
  end
  return out
end

local headers = {
    lineColor(neovim_cool, pallete.bright_yellow, pallete.bright_orange),
    lineColor(neovim_cool, pallete.bright_yellow, pallete.bright_red),
    lineColor(hanna_logo, hanna_blue,"#1d2021"),
    lineColor(hanna_logo, hanna_blue,pallete.dark_aqua),
}

local function random_header()
    math.randomseed(os.time())
    return headers[math.random(#headers)]
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function colored_header()

    local lines = {}
    for _, lineConfig in pairs(random_header()) do
      local hi = lineConfig.hi
      local line_chars = lineConfig.line
      local line = {
            type = "text",
            val = line_chars,
            opts = {
                  hl = hi,
                  shrink_margin = false,
                  position = "center",
                },
              }
              table.insert(lines, line)
            end

    local output = {
        type = "group",
        val = lines,
        opts = { position = "center", hl = 'AlphaHeader'},
    }

    return output
end


return {
    'goolord/alpha-nvim', 
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.opts.layout[2] = colored_header()
        -- how to add devicons and nerdfont icons?
        -- in INSERT mode (not normal) <C-v>uF002 will add .
        -- dashboard.section.header.val = colored_header()
        -- dashboard.section.header = colored_header()
        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("u", "󰜷  > Update", function() require("lazy").update() end),
            dashboard.button("t", "  > Temp file", ":cd C:/temp | :e "),
            dashboard.button("r", "  > Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"), -- | split . | wincmd k | pwd<CR>"),
            dashboard.button("q", "  > Quit", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)

        -- Show the amoung of time it took to update
        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "  Neovim loaded "
                .. stats.loaded
                .. "/"
                .. stats.count
                .. " plugins in "
                .. ms
                .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end
}
