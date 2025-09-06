return {
    'goolord/alpha-nvim', 
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")


        -- how to add devicons and nerdfont icons? 
        -- in INSERT mode (not normal) <C-v>uF002 will add . 
        --

        -- FIGLET SETUP 
        -- (figlet is used for generating some of the ascii text shown below)
        -- sudo apt install figlet
        -- clone github.com/xero/figlet-fonts 
        -- move the font files into usr/share/figlet/fonts/
        -- run the appropriate commands

        dashboard.section.header.val = {


        -- figlet -f /usr/share/figlet/fonts/3d.flf "NeoTim"

        [[  ██████████ ██             ██      ██ ██            ]],
        [[ ░░░░░██░░░ ░░             ░██     ░██░░             ]],
        [[     ░██     ██ ██████████ ░██     ░██ ██ ██████████  ]],
        [[     ░██    ░██░░██░░██░░██░░██    ██ ░██░░██░░██░░██ ]],
        [[     ░██    ░██ ░██ ░██ ░██ ░░██  ██  ░██ ░██ ░██ ░██ ]],
        [[     ░██    ░██ ░██ ░██ ░██  ░░████   ░██ ░██ ░██ ░██ ]],
        [[     ░██    ░██ ███ ░██ ░██   ░░██    ░██ ███ ░██ ░██ ]],
        [[     ░░     ░░ ░░░  ░░  ░░     ░░     ░░ ░░░  ░░  ░░  ]],
        -- figlet -f ANSI\ Shadow "TIMVIM"

        -- [[ ████████╗██╗███╗   ███╗██╗   ██╗██╗███╗   ███╗ ]],
        -- [[ ╚══██╔══╝██║████╗ ████║██║   ██║██║████╗ ████║ ]],
        -- [[    ██║   ██║██╔████╔██║██║   ██║██║██╔████╔██║ ]],
        -- [[    ██║   ██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        -- [[    ██║   ██║██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        -- [[    ╚═╝   ╚═╝╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        -- This is not unforunately by figlet, I guess someone did this by hand
        --   [[                                                                       ]],
        --   [[                                                                       ]],
        --   [[                                                                       ]],
        --   [[                                                                       ]],
        --   [[                                                                     ]],
        --   [[       ████ ██████           █████      ██                     ]],
        --   [[      ███████████             █████                             ]],
        --   [[      █████████ ███████████████████ ███   ███████████   ]],
        --   [[     █████████  ███    █████████████ █████ ██████████████   ]],
        --   [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        --   [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        --   [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        --   [[                                                                       ]],
        --   [[                                                                       ]],
        --   [[                                                                       ]],
        }


        
        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
            dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
            dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
            dashboard.button( "q", "  > Quit", ":qa<CR>"),
        }
        alpha.setup(dashboard.opts)




    end
}
