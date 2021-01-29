local bufferline = require('bufferline')
local ayu_get_color = vim.fn['ayu#get_color']

local function custom_highlights()
  if vim.g.colors_name ~= 'ayu' then
    return nil
  end

  return {
    fill = {
      guifg = '',
      guibg = ayu_get_color('panel_bg')
    },
    separator_selected = {
      guifg = ayu_get_color('panel_bg')
    },
    separator_visible = {
      guifg = ayu_get_color('panel_bg')
    },
    separator = {
      guifg = ayu_get_color('panel_bg')
    }
  }
end

bufferline.setup{
  options = {
    --numbers = 'ordinal',
    show_buffer_close_icons = false,
    separator_style = 'slant',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""
      return " " .. icon .. count
    end,
  },
  highlights = custom_highlights()
}
