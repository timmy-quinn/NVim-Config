-- Lualine configuration 
vim.o.showmode = false
local custom_gruvbox = require('lualine.themes.gruvbox')

-- This switches around the configurations. 
-- Note: if you run :source, then the colors will be further flipped
custom_gruvbox.visual = custom_gruvbox.insert
custom_gruvbox.insert = custom_gruvbox.replace 



require('lualine').setup {
  options = {
    theme = custom_gruvbox,
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {
      lualine_c = {
          {
          'buffers',
          max_length = vim.o.columns*0.7,
          show_filename_only = true, 
          show_modified_status=true, 
          use_mode_colors=true,
          buffers_color = {
            -- Same values as the general color option can be used here.
            active = {fg = '#c0c0d0', gui ='italic,bold'},     -- Color for active buffer.
            inactive = 'lualine_c_inactive', -- Color for inactive buffer.
          },
          symbols = {
            modified = ' ●',      -- Text to show when modified
          }, 
        }
      }, 
      lualine_z = {'tabs'}
  }

}
-- vim.api.nvim_set_hl(0, 'lualine_buffer_active', {link = 'Visual'}) 
