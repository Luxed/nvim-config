return {
  'akinsho/nvim-bufferline.lua',
  branch = 'main',
  config = function()
    require('bufferline').setup {
      options = {
        show_buffer_close_icons = false,
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
                or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end
      }
    }
  end
}
