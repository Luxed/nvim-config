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

local custom_telescope = {}

custom_telescope.branch = function(opts)
  local branches = vim.fn.systemlist('git branch -r --sort=-committerdate --format="%(refname:lstrip=3)"')
  local current_branch = vim.fn.systemlist('git branch --show-current')[1]

  local results = {}
  for i=1, #branches do
    local branch = branches[i]
    if branch ~= current_branch and branch ~= "HEAD" then
      table.insert(results, branches[i])
    end
  end

  pickers.new(opts, {
    prompt = 'Branches',
    finder = finders.new_table(results),
    sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function (_, map)
      map('i', '<CR>', checkout_actions.set_branch)
      return true
    end,
  }):find()
end

custom_telescope.tags = function(opts)
  local tags_str = vim.fn.systemlist('git ls-remote -t --refs')
  table.remove(tags_str, 1)

  local results = {}
  for i=1, #tags_str do
    local tag = vim.fn.substitute(tags_str[i], '^.*refs/tags/', '', '')
    table.insert(results, tag)
  end

  pickers.new(opts, {
    prompt = 'Tags',
    finder = finders.new_table(results),
    sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function (_, map)
      map('i', '<CR>', checkout_actions.set_branch)
      return true
    end,
  }):find()
end

return custom_telescope
