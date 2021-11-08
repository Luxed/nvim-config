local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local map = require('helpers.map')

local checkout_actions = {}

-- TODO: Redo tags selection + make PR to add it upstream
checkout_actions.set_branch = function(prompt_bufnr)
  local entry = actions.get_selected_entry(prompt_bufnr)

  actions.close(prompt_bufnr)

  local git_cmd = '!git checkout ' .. entry.value
  vim.cmd(git_cmd)
end

local function tags(opts)
  opts = opts or {}
  local tags_list = vim.fn.systemlist('git ls-remote -t --refs')
  table.remove(tags_list, 1)

  local results = {}
  for _, tag in pairs(tags_list) do
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

local function rg(opts)
  local input = vim.fn.input('Ripgrep: ')

  if input ~= '' then
    opts = opts or {}
    builtin.grep_string(vim.tbl_extend('force', opts, {search = input}))
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

    local fix_folds = {
      attach_mappings = function(_)
        -- TEMP: Fix fold issues (https://github.com/nvim-telescope/telescope.nvim/issues/559)
        require('telescope.actions.set').select:enhance{
          post = function(_)
            vim.cmd(':normal zx')
          end
        }
        return true
      end
    }

    map.lua('n', '<leader>ff', function() builtin.find_files(fix_folds) end)
    map.lua('n', '<leader>fb', function() builtin.buffers({ show_all_buffers = true }) end)
    map.lua('n', '<leader>fg', function() rg(fix_folds) end)
    map.lua('n', '<leader>gb', builtin.git_branches)
    map.lua('n', '<leader>gt', tags)
  end
}
