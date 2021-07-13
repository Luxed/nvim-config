local enabled = { 'c_sharp', 'css', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'query', 'rust', 'typescript', 'yaml' }
local disabled = {           'css', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python',          'rust', 'typescript', 'yaml' }

require('nvim-treesitter.configs').setup {
  ensure_installed = enabled,
  highlight = {
    enable = true,
  },
  -- TODO: It looks OK by default but would be better with a custom list of colors
  -- Maybe from a simple gradient? Would be cool and minimal
  rainbow = {
    enable = true
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
