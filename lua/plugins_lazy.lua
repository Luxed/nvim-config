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
  {
    'Luxed/ayu-vim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('colorscheme')
    end,
    priority = 1000
  },

  'editorconfig/editorconfig-vim',
  'mboughaba/i3config.vim',
  'PProvost/vim-ps1',
  'blankname/vim-fish',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
      'nvim-treesitter/playground',
    },
    config = function()
      require('plugins.treesitter')
    end
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup({})
    end
  },

  {
    'tpope/vim-fugitive',
    config = function() require('plugins.fugitive') end
  },
  { 'junegunn/gv.vim', cmd = 'GV' },

  {
    'windwp/nvim-autopairs',
    config = function() require('plugins.autopairs') end
  },
  'windwp/nvim-ts-autotag',

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
  'tpope/vim-surround',

  {
    'goolord/alpha-nvim',
    config = function() require('plugins.alpha') end
  },

  'wellle/targets.vim',
  'tpope/vim-repeat',
  'rhysd/clever-f.vim',

  { -- LuaSnip
    'L3MON4D3/LuaSnip',
    config = function()
      require('plugins.luasnip')
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      require('plugins.cmp')
    end
  },

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

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  { 'godlygeek/tabular', cmd = 'Tabularize' },

  { -- colorizer
    'NvChad/nvim-colorizer.lua',
    config = function() require('plugins.colorizer') end
  },

  require('plugins.telescope'),

  { -- lualine
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.lualine') end
  },

  { -- bufferline
    'akinsho/nvim-bufferline.lua',
    branch = 'main',
    config = function() require('plugins.bufferline') end
  },

  { -- indent-blankline
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent_blankline')
    end
  },

  { -- dressing.nvim
    'stevearc/dressing.nvim',
    config = function() require('plugins.dressing') end
  },

  { -- notify
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.notify')
    end
  },

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
      'onsails/lspkind-nvim',
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

      { -- neodim
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = function() require('plugins.dim') end
      },

      -- LSP installer
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
    config = function() require('plugins.lsp') end,
  },

  require('plugins.dap'),

  'Luxed/aw-watcher-nvim'
})
