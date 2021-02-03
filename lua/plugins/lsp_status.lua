local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lsp_status_config = {
  kind_labels = {
    ['Function'] = 'F',
    ['Method'] = 'M',
    ['Class'] = 'C',
  },
  current_function = true,
  indicator_separator = ' ',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = 'ﯦ',
  indicator_ok = '',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
  status_symbol = ' ',
  select_symbol = function(cursor_pos, symbol)
    -- fix for sumneko lua
    if symbol.valueRange then
      local value_range = {
        ['start'] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ['end'] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require('lsp-status.util').in_range(cursor_pos, value_range)
    end

    return nil
  end
}
lsp_status.config(lsp_status_config)
