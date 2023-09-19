return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
  },
  config = function()
    require('go').setup({
      dap_debug_keymap = false, -- They never get removed from the buffer, super annoying
    })
  end,
  event = { 'CmdLineEnter' },
  ft = { 'go', 'gomod' },
  -- build = ':lua require("go.install").update_all_sync()'
}
