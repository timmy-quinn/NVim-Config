return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            options = {
                show_source = {
                    enabled = true,
                    if_many = false
                }
            },
        })
        vim.diagnostic.config({virtual_text = false}) --, underline = true})

        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "Red" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { underline = true, sp = "Yellow" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { underline = true, sp = "Blue" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { underline = true, sp = "Cyan" })


        -- If using tmux, add this to .tmux.conf
        -- # Undercurl
        -- set -g default-terminal "${TERM}"
        -- set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
        -- set -as terminal-overrides ',*:Setulc=\E[58::2::::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    end
}
