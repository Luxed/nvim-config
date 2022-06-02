require('dressing').setup({
  input = {
    enabled = false,
  },
  select = {
    telescope = require('telescope.themes').get_cursor({
      layout_config = {
        height = 14
      }
    })
  }
})
