local bufferline = require('bufferline')

return {
  init = function()
    bufferline.setup{
      options = {
        numbers = 'ordinal',
        show_buffer_close_icons = false,
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or ""
          return " " .. icon .. count
        end
      },
    }
  end
}
