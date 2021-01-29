local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')

local checkout_actions = {}

checkout_actions.set_branch = function(prompt_bufnr)
  local entry = actions.get_selected_entry(prompt_bufnr)

  actions.close(prompt_bufnr)

  local git_cmd = '!git checkout ' .. entry.value
  vim.cmd(git_cmd)
end

local M = {}

M.branch = function(opts)
  local branches = vim.fn.systemlist('git branch -r --sort=-committerdate --format="%(refname:lstrip=3)"')
  local current_branch = vim.fn.systemlist('git branch --show-current')[1]

  local results = {}
  for _, branch in pairs(branches) do
    if branch ~= current_branch and branch ~= "HEAD" then
      table.insert(results, branch)
    end
  end

  pickers.new(opts, {
    prompt = 'Branches',
    finder = finders.new_table(results),
    sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function (_, map)
      map('i', '<CR>', checkout_actions.set_branch)
      map('n', '<CR>', checkout_actions.set_branch)
      return true
    end,
  }):find()
end

M.tags = function(opts)
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

M.rg = function()
  local input = vim.fn.input('Ripgrep: ')

  if input ~= '' then
    require('telescope.builtin').grep_string({search = input})
  else
    print('Exiting: given input was empty')
  end
end

M.init = function()
  local map = require('helpers.map')
  require('telescope').setup {
    defaults = {
      --prompt_prefix = "λ",
      prompt_prefix = "",
      layout_strategy = 'flex',
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      generic_sorter = require('telescope.sorters').get_fzy_sorter,
      mappings = {
        i = {
          -- close in insert mode
          ['<esc>'] = require('telescope.actions').close
        }
      }
    }
  }

  map.nnore('<leader>ff', ':lua require("telescope.builtin").find_files()<CR>', {silent = true})
  map.nnore('<leader>fb', ':lua require("telescope.builtin").buffers({show_all_buffers = true})<CR>', {silent = true})
  map.nnore('<leader>fg', ':lua require("plugins.telescope").rg()<CR>', {silent = true})
  map.nnore('<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>')
  map.nnore('<leader>gt', ':lua require("plugins.telescope").tags({})<CR>')
end

return M
