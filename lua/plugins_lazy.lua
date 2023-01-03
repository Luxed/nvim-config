local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=main", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require('colorscheme'),

  'editorconfig/editorconfig-vim',
  'mboughaba/i3config.vim',
  'PProvost/vim-ps1',
  'blankname/vim-fish',

  require('plugins.treesitter'),
  require('plugins.git'),
  require('plugins.autopairs'),
  require('plugins.neo_tree'),

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        mappings = {
          basic = false,
          extra = false,
          extended = false
        }
      }

      require('keymaps').comments()
    end
  },

  require('plugins.alpha'),

  'tpope/vim-surround',
  'wellle/targets.vim',
  'tpope/vim-repeat',
  'rhysd/clever-f.vim',

  require('plugins.lualine'),
  require('plugins.luasnip'),
  require('plugins.cmp'),

  { -- FixCursorHold
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end
  },

  { -- todo-comments.nvim
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup()
    end
  },

  { 'godlygeek/tabular', cmd = 'Tabularize' },

  require('plugins.colorizer'),
  require('plugins.telescope'),
  require('plugins.lualine'),
  require('plugins.bufferline'),
  require('plugins.indent_blankline'),
  require('plugins.dressing'),
  require('plugins.notify'),

  { -- vim-illuminate
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter',
          -- 'regex' -- Currently disabled, but might be useful in some cases
        },
        delay = 100,
        under_cursor = false, -- Highlight any word under the cursor
      })
    end
  },

  { -- lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      'Hoffs/omnisharp-extended-lsp.nvim',
      'Luxed/omnisharp-nvim',
      'kosayoda/nvim-lightbulb',
      'simrat39/rust-tools.nvim',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup({})
        end
      },
      'SmiteshP/nvim-navic',

      -- LSP installer
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
    config = function() require('plugins.lsp') end,
  },
  require('plugins.dim'),
  require('plugins.dap'),

  'Luxed/aw-watcher-nvim'
})
