-- local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

return {
  'tpope/vim-surround',
  'wellle/targets.vim',
  'tpope/vim-repeat',
  'rhysd/clever-f.vim',
  { 'godlygeek/tabular', cmd = 'Tabularize' },
  --[[ {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        mappings = {
          basic = false,
          extra = false,
          extended = false
        }
      }
    end,
    lazy = true,
    keys = {
      { '<leader>cc', function() require('Comment.api').toggle.linewise.current() end },
      { '<leader>cu', function() require('Comment.api').uncomment.linewise.current() end },
      {
        '<leader>cm',
        function()
          vim.api.nvim_feedkeys(esc, 'nx', false)
          require('Comment.api').toggle.blockwise(vim.fn.visualmode())
        end,
        mode = 'x',
      },
      {
        '<leader>cc',
        function()
          vim.api.nvim_feedkeys(esc, 'nx', false)
          require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end,
        mode = 'x',
      },
      {
        '<leader>cu',
        function()
          vim.api.nvim_feedkeys(esc, 'nx', false)
          local ft = require('Comment.ft')
          local u = require('Comment.utils')
          if not ft.get(vim.bo.filetype, u.ctype.blockwise) then
            require('Comment.api').uncomment.linewise(vim.fn.visualmode())
          else
            require('Comment.api').uncomment.blockwise(vim.fn.visualmode())
          end
        end,
        mode = 'x'
      }
    }
  }, ]]
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        mappings = {
          basic = true,
          extra = false,
        },
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb'
        }
        --[[ toggler = {
          line = '<leader>cc',
          block = '<leader>cm',
        }, ]]
        --[[ opleader = {
          line = '<leader>c',
          block = '<leader>c'
        } ]]
      })
    end
  },
}
