local enabled = { 'c_sharp', 'css', 'go', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'query', 'rust', 'sql', 'typescript', 'vim', 'vue', 'yaml' }
local disabled = {           'css', 'go', 'html', 'javascript', 'jsdoc',         'lua', 'python',          'rust',        'typescript', 'vim', 'vue', 'yaml' }

require('nvim-treesitter.configs').setup {
  ensure_installed = enabled,
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { 'html' },
    colors = require('ayu').rainbow_colors()
  },
  indent = {
    enable = true,
    disable = disabled
  },
  refactor = {
    highlight_definitions = {
      enable = false,
      -- Disable for languages that support highlighting through LSP (it usually gives better results)
      disable = disabled
    },
    smart_rename = {
      enable = false,
      keymaps = {
        smart_rename = 'grr'
      }
    }
  },
  playground = {
    enable = true,
  }
}
