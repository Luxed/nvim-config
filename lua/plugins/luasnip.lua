return {
  'L3MON4D3/LuaSnip',
  config = function()
    require('keymaps').luasnip()

    require('luasnip.loaders.from_vscode').lazy_load({
      paths = './vsnip/'
    })
  end
}
