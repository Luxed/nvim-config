vim.cmd('packadd completion-nvim')
vim.cmd('packadd completion-buffers')

local map = require('helpers.map')
local au = require('helpers.command').autocmd

local function setup_mappings()
  vim.api.nvim_set_keymap(
    'i',
    '<CR>',
    'pumvisible() ? complete_info()["selected"] != "-1" ? "\\<Plug>(completion_confirm_completion)" : "\\<C-e><CR>" : "\\<CR>"',
    { expr = true })

  map.inore('<C-Space>', 'completion#trigger_completion()', {silent = true, expr = true})
end

return {
  options = {
    -- This option gives me some _heavy_ flickering with paths
    --auto_change_source = 1,
    enable_snippet = 'vim-vsnip',
    timer_cycle = 40,
    matching_strategy_list = {'exact', 'fuzzy'},
    --sorting = 'length', -- possible values: 'length', 'alphabet', 'none'
    sorting = 'length',
    confirm_key = '', -- disable default confirm mapping
    -- TODO: something to look into
    --items_priority = {
      --Function = 0,
      --Buffers = 2
    --},
    chain_complete_list = {
      fugitive = {
        default = {
          { complete_items = { 'snippet', 'buffers' } }
        }
      },
      default = {
        default = {
          { complete_items = { 'lsp', 'snippet', 'buffers' } },
        },
        string = {
          { complete_items = { 'buffers' } }
        },
        comment = {}
      }
    }
  },
  init = function()
    au('BufEnter', '*', 'lua require("completion").on_attach(require("plugins.completion").options)')
    setup_mappings()
  end
}
