local enabled = { 'c_sharp', 'css', 'go', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'rust', 'sql', 'typescript', 'vim', 'vue', 'yaml' }

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
    disable = {
      'css',
      'go',
      'html',
      'javascript', 'jsdoc',
      'lua',
      'markdown', 'markdown_inline',
      'python',
      'rust',
      'typescript',
      'vim', 'vue',
      'yaml'
    }
  },
  playground = {
    enable = true,
  }
}
