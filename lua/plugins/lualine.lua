require('lualine').setup({
  sections = {
    lualine_x = {
      function()
        return require('lsp-status').status()
      end,
      'encoding',
      'fileformat',
      'filetype'
    }
  },
  extensions = { 'fern', 'fugitive' }
})
