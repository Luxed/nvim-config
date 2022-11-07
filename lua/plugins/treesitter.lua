local enabled = {
  'c_sharp', 'css',
  'dockerfile',
  'go',
  'html',
  'javascript', 'jsdoc', 'json',
  'lua',
  'markdown', 'markdown_inline',
  'nix',
  'python',
  'query',
  'rust',
  'sql',
  'typescript', 'tsx',
  'vim', 'vue',
  'yaml'
}

require('nvim-treesitter.configs').setup {
  ensure_installed = enabled,
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { 'html', 'tsx' },
    colors = require('ayu').rainbow_colors()
  },
  indent = {
    enable = true,
    disable = {
      'css',
      'go',
      'html',
      'javascript', 'jsdoc',
      'lua',
      'markdown', 'markdown_inline',
      'nix',
      'python',
      'rust',
      'vim',
      'yaml'
    }
  },
  playground = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    }
  },
  autotag = {
    enable = true
  }
}
