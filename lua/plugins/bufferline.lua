local bufferline = require('bufferline')
local ayu_get_color = vim.fn['ayu#get_color']

local function custom_highlights()
  if vim.g.colors_name ~= 'ayu' then
    return nil
  end

  return {
    fill = {
      guifg = '',
      guibg = ayu_get_color('panel_border')
    },
    buffer_selected = {
      guibg = ayu_get_color('panel_bg')
    },
    buffer_visible = {
      guibg = ayu_get_color('panel_shadow')
    },
    separator_selected = {
      guifg = ayu_get_color('panel_border'),
      guibg = ayu_get_color('panel_bg')
    },
    separator_visible = {
      guifg = ayu_get_color('panel_border'),
      guibg = ayu_get_color('panel_shadow')
    },
    separator = {
      guifg = ayu_get_color('panel_border')
    },
    duplicate_selected = {
      guibg = '',
    },
    duplicate_visible = {
      guibg = ''
    },
    modified_selected = {
      guibg = ayu_get_color('panel_bg')
    },
    modified_visible = {
      guibg = ayu_get_color('panel_shadow')
    },
    warning_selected = {
      guibg = ayu_get_color('panel_bg')
    },
    warning_visible = {
      guibg = ayu_get_color('panel_shadow')
    },
    error_selected = {
      guibg = ayu_get_color('panel_bg'),
      guifg = ayu_get_color('error')
    },
    error_visible = {
      guibg = ayu_get_color('panel_shadow')
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
