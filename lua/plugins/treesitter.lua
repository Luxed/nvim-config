local enabled = { 'c_sharp', 'css', 'go', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'query', 'rust', 'typescript', 'yaml' }
local disabled = {           'css', 'go', 'html', 'javascript', 'jsdoc',         'lua', 'python',          'rust', 'typescript', 'yaml' }

require('nvim-treesitter.configs').setup {
  ensure_installed = enabled,
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { 'html' },
    colors = require('ayu').rainbow_colors
  },
  indent = {
    enable = true,
    disable = disabled
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Disable for languages that support highlighting through LSP (it usually gives better results)
      disable = disabled
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr'
      }
    }
  },
  playground = {
    enable = true,
  }
}
