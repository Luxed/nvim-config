local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local map = require('helpers.map')

local checkout_actions = {}

checkout_actions.set_branch = function(prompt_bufnr)
  local entry = actions.get_selected_entry(prompt_bufnr)

  actions.close(prompt_bufnr)

  local git_cmd = '!git checkout ' .. entry.value
  vim.cmd(git_cmd)
end

function tags(opts)
  opts = opts or {}
  local tags = vim.fn.systemlist('git ls-remote -t --refs')
  table.remove(tags, 1)

  local results = {}
  for _, tag in pairs(tags) do
    tag = vim.fn.substitute(tag, '^.*refs/tags/', '', '')
    table.insert(results, tag)
  end

  pickers.new(opts, {
    prompt = 'Tags',
    finder = finders.new_table(results),
    sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function (_, map)
      map('i', '<CR>', checkout_actions.set_branch)
      map('n', '<CR>', checkout_actions.set_branch)
      return true
    end,
  }):find()
end

function rg()
  local input = vim.fn.input('Ripgrep: ')

  if input ~= '' then
    builtin.grep_string({search = input})
  else
    print('Exiting: given input was empty')
  end
end

return {
  code_actions = function()
    builtin.lsp_code_actions(themes.get_cursor())
  end,
  init = function()
    require('telescope').setup {
      defaults = {
        prompt_prefix = " ",
        layout_strategy = 'flex',
        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_fzy_sorter,
        mappings = {
          i = {
            -- close in insert mode
            ['<esc>'] = require('telescope.actions').close
          }
        }
      }
    }

    map.lua('n', '<leader>ff', function() builtin.find_files() end)
    map.lua('n', '<leader>fb', function() builtin.buffers({ show_all_buffers = true }) end)
    map.lua('n', '<leader>fg', rg)
    map.lua('n', '<leader>gb', function() builtin.git_branches() end)
    map.lua('n', '<leader>gt', tags)
  end
}
