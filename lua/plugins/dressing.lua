return { -- dressing.nvim
  'stevearc/dressing.nvim',
  config = function()
    require('dressing').setup({
      input = {
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
      },
      select = {
        telescope = require('telescope.themes').get_cursor({
          layout_config = {
            height = 14
          }
        })
      }
    })
  end
}
