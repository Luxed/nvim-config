require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c_sharp', 'lua', 'rust' },
  highlight = {
    enable = true,
  },
  --[[rainbow = {
    enable = true
  },]]
  --[[indent = {
    enable = true
  },]]
  refactor = {
    -- Not a fan, but it works as expected
    --highlight_current_scope = { enable = true },
    highlight_definitions = {
      -- NOTE: Disabled after it gave me _horrible_ results in the big C codebase of Neovim. It was very slow.
      enable = false,
      -- Disable for languages that support highlighting through LSP (it usually gives better results)
      disable = { 'lua' }
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
