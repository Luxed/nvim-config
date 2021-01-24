local map = require('helpers.map')

-- TODO: move all config in this file directly, nothing needs to be returned here

return {
  setup_mappings = function()
    vim.api.nvim_set_keymap(
      'i',
      '<CR>',
      'pumvisible() ? complete_info()["selected"] != "-1" ? "\\<Plug>(completion_confirm_completion)" : "\\<C-e><CR>" : "\\<CR>"',
      { expr = true })

    map.inore('<C-Space>', 'completion#trigger_completion()', {silent = true, expr = true})
  end,
  options = {
    -- This option gives me some _heavy_ flickering with paths
    --auto_change_source = 1,
    enable_snippet = 'vim-vsnip',
    timer_cycle = 40,
    matching_strategy_list = {'exact', 'fuzzy'},
    sorting = 'length', -- possible values: 'length', 'alphabet', 'none'
    confirm_key = '', -- disable default confirm mapping
    chain_complete_list = {
      default = {
        default = {
          { complete_items = { 'lsp', 'snippet' } },
          --{ complete_items = { 'path' }, triggered_only = { '/' } },
          { mode = '<c-p>' },
          { mode = '<c-n>' }
        },
        string = {
          { complete_items = { 'path' }, triggered_only = { '/' } }
        },
        comment = {}
      }
    }
  }
}
