local enabled = { 'c_sharp', 'css', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'query', 'rust', 'typescript', 'yaml' }
local disabled = {           'css', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python',          'rust', 'typescript', 'yaml' }

require('nvim-treesitter.configs').setup {
  ensure_installed = enabled,
  highlight = {
    enable = true,
  },
  --[[rainbow = {
    enable = true
  },]]
  indent = {
    enable = true,
    disable = disabled
  },
  refactor = {
    -- Not a fan, but it works as expected
    --highlight_current_scope = { enable = true },
    highlight_definitions = {
      -- NOTE: Disabled after it gave me _horrible_ results in the big C codebase of Neovim. It was very slow.
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
