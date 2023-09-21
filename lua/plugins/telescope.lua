local checkout_actions = {}

-- TODO: Redo tags selection + make PR to add it upstream
checkout_actions.set_branch = function(prompt_bufnr)
  local actions = require('telescope.actions')
  local entry = actions.get_selected_entry(prompt_bufnr)

  actions.close(prompt_bufnr)

  local git_cmd = '!git checkout ' .. entry.value
  vim.cmd(git_cmd)
end

local function tags(opts)
  local pickers = require('telescope.pickers')
  local sorters = require('telescope.sorters')
  local finders = require('telescope.finders')
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

local function rg(opts, under_cursor)
  vim.ui.input({ prompt = 'Ripgrep:', default = under_cursor and vim.fn.expand('<cword>') or '' }, function(input)
    if input then
      require('telescope.builtin').grep_string(vim.tbl_extend('force', opts, {search = input}))
    else
      vim.notify('Exiting: given input was empty', vim.log.levels.WARN)
    end
  end)
end

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

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local sorters = require('telescope.sorters')

    local default_theme = require('telescope.themes').get_dropdown({
      prompt_prefix = " ",
      layout_strategy = 'center',
      file_sorter = sorters.get_fzy_sorter,
      generic_sorter = sorters.get_fzy_sorter,
      layout_config = {
        width = function(self, max_columns, max_lines)
          local columns = max_columns - 20*2
          if columns > 200 then
            return 200
          elseif columns > 80 then
            return columns
          else
            return 80
          end
        end
      },
      mappings = {
        i = {
          -- close in insert mode
          ['<esc>'] = require('telescope.actions').close
        }
      }
    })

    require('telescope').setup {
      defaults = default_theme
    }
  end,
  lazy = true,
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files(fix_folds) end },
    { '<leader>fb', function() require('telescope.builtin').buffers({ show_all_buffers = true }) end },
    { '<leader>fg', function() rg(fix_folds, false) end },
    { '<leader>fG', function() rg(fix_folds, true) end },
    { '<leader>fc', function() require('telescope.builtin').current_buffer_fuzzy_find(fix_folds) end },
    { '<leader>gb', function() require('telescope.builtin').git_branches() end },
    { '<leader>gt', function() tags() end },
  }
}
