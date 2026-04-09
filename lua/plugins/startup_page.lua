local colors = require("utils.colors")
local hanna_blue = "#005eb8"
local background ="#1d2021"
local pallete = colors.get_theme_palette()

-- -- FIGLET SETUP 
-- -- (figlet is used for generating some of the ascii text shown below)
-- -- sudo apt install figlet
-- -- clone github.com/xero/figlet-fonts 
-- -- move the font files into usr/share/figlet/fonts/
-- -- run the appropriate commands
-- -- figlet -f /usr/share/figlet/fonts/3d.flf "NeoTim"
-- local tim_vim  = {
--     [[  ██████████ ██             ██      ██ ██            ]],
--     [[ ░░░░░██░░░ ░░             ░██     ░██░░             ]],
--     [[     ░██     ██ ██████████ ░██     ░██ ██ ██████████  ]],
--     [[     ░██    ░██░░██░░██░░██░░██    ██ ░██░░██░░██░░██ ]],
--     [[     ░██    ░██ ░██ ░██ ░██ ░░██  ██  ░██ ░██ ░██ ░██ ]],
--     [[     ░██    ░██ ░██ ░██ ░██  ░░████   ░██ ░██ ░██ ░██ ]],
--     [[     ░██    ░██ ███ ░██ ░██   ░░██    ░██ ███ ░██ ░██ ]],
--     [[     ░░     ░░ ░░░  ░░  ░░     ░░     ░░ ░░░  ░░  ░░  ]],
-- }
-- -- figlet -f ANSI\ Shadow "TIMVIM"

-- local tim_vim_shadow = {
--     [[ ████████╗██╗███╗   ███╗██╗   ██╗██╗███╗   ███╗ ]],
--     [[ ╚══██╔══╝██║████╗ ████║██║   ██║██║████╗ ████║ ]],
--     [[    ██║   ██║██╔████╔██║██║   ██║██║██╔████╔██║ ]],
--     [[    ██║   ██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
--     [[    ██║   ██║██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
--     [[    ╚═╝   ╚═╝╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
-- }
-- -- This is not unforunately by figlet, I guess someone did this by hand
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


local headers = {
    {"h", neovim_cool, pallete.bright_yellow, pallete.bright_orange},
    {"h", neovim_cool, pallete.dark_red, pallete.dark_purple},
    {"v", hanna_logo, hanna_blue, hanna_blue},
    {"v", hanna_logo, hanna_blue, pallete.dark_aqua},
}


local function lineColor(lines, start_color, end_color)
    local out = {}
    local prefix = "startup_header"
    -- we define a range of highlight colors. 
    -- Then later we can assign each line in our  
    colors.create_gradient_highlights(start_color,end_color, #lines, prefix)
    for i, line in ipairs(lines) do
        local hi = prefix .. i
        table.insert(out, { hi = hi, line = line})
    end
    return out
end

local function horizontalGradient(lines, start_color, end_color)

    local utils = require('alpha.utils')
    local header_hl = {}
    local header_hl_line = {}
    local max = 0

    for i, line in ipairs(lines) do
        local line_len = vim.api.nvim_strwidth(line)
        if line_len > max then
            max = line_len
        end
    end
    local prefix = "startup_header"
    colors.create_gradient_highlights(start_color,end_color, max, prefix)
    for i=1,max do
        header_hl_line[i] = {prefix .. i, i - 1, i }
    end
    for i, _ in ipairs(lines) do
        header_hl[i] = header_hl_line
    end

    return utils.charhl_to_bytehl(header_hl, lines, false)
end

local function random_header()
    math.randomseed(os.time())
    return headers[math.random(#headers)]
end


local function colored_header(dashboard)
    local header_config = random_header()
    local gradient_dir = header_config[1]
    local header_txt = header_config[2]
    local start_color = header_config[3]
    local end_color = header_config[4]

    if gradient_dir == "h" then
        local header_hl = horizontalGradient(header_txt, start_color, end_color)
        dashboard.section.header.val = header_txt
        dashboard.section.header.opts.hl = header_hl
    else
        local lines = {}
        local header = lineColor(header_txt, start_color, end_color)
        for _, lineConfig in pairs(header) do
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

        dashboard.opts.layout[2] = output
    end
end


return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        -- dashboard.header.val = colored_header()
        colored_header(dashboard)
        -- dashboard.opts.layout[2] = colored_header()
        -- how to add devicons and nerdfont icons?
        -- in INSERT mode (not normal) <C-v>uF002 will add .
        -- dashboard.section.header.val = colored_header()
        -- dashboard.section.header = colored_header()
        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("u", "󰜷  > Update", function() require("lazy").update() end),
            dashboard.button("t", "  > Temp file", function()
                vim.cmd("cd C:/temp")
                vim.api.nvim_feedkeys(":e ", "n", false)
                -- vim.cmd("normal :e ")
            end), -- ":cd C:/temp | :e "),
            dashboard.button("n", "󰙏  > Note", function() 
                vim.cmd("cd C:/Notes")
                vim.cmd("NvimTreeToggle<CR>")
            end), -- :cd C:/Notes | <cmd>NvimTreeToggle<CR><CR>"),
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
