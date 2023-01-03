return {
  'NvChad/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      filetypes = {
        css = {
          css = true,
        },
        scss = {
          css = true,
        },
        cfg = {
          names = false,
          RRGGBBAA = true,
        },
        dosini = {
          names = false,
        },
        lua = {
          names = false,
        },
        vim = {
          names = false,
        }
      }
    }
  end
}
