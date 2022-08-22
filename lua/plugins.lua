local function bootstrap()
  local data_path = vim.fn.stdpath('data')
  local packer_path = data_path .. '/site/pack/packer/opt/packer.nvim'
  local not_installed = vim.fn.isdirectory(packer_path) == 0

  if not_installed then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  end

  vim.cmd('packadd packer.nvim')

  return not_installed
end

local function startup(use)
  use({'wbthomason/packer.nvim', opt = true})

  local function languages()
    -- File Format
    use('editorconfig/editorconfig-vim')
    use('mboughaba/i3config.vim')
    use{'cespare/vim-toml', branch = 'main'}
    -- Glsl
    use('tikhomirov/vim-glsl')
    -- Shell
    use('PProvost/vim-ps1')
    use('blankname/vim-fish')

    use{'openembedded/bitbake', rtp = 'contrib/vim'}

    use{ -- TreeSitter
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/playground',
        { -- hlargs.nvim
          'm-demare/hlargs.nvim',
          config = function()
            require('hlargs').setup({})
          end
        }
      },
      config = function()
        require('plugins.treesitter')
      end
    }
  end

  local function utility()
    use{ -- Fugitive: Git integration
      'tpope/vim-fugitive',
      config = function() require('plugins.fugitive') end
    }
    use{'junegunn/gv.vim', opt = true, cmd = {'GV'}} -- Git log graphical visualisation
    use{ -- autopairs
      'windwp/nvim-autopairs',
      config = function() require('plugins.autopairs') end
    }
    use{ -- Auto close html tags
      'alvan/vim-closetag',
      config = function()
        vim.g['closetag_filenames'] = '*.html,*.xhtml,*.phtml,*.vue,*.xml'
        vim.g['closetag_filetypes'] = 'html,xhtml,phtml,vue,xml'
      end
    }

    use{
      'nvim-neo-tree/neo-tree.nvim',
      requires = {
        'MunifTanjim/nui.nvim'
      },
      config = function()
        require('plugins.neo_tree')
      end
    }

    use{ -- Comment.nvim
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup{
          mappings = {
            basic = false,
            extra = false,
            extended = false
          }
        }

        require('keymaps').comments()
      end
    }
    use('tpope/vim-surround') -- Surround (visually select and surround with what you want)
    use{'AndrewRadev/bufferize.vim', opt = true, cmd = {'Bufferize'}} -- Execute commands in a buffer
    use{ -- Startify: Nice startup screen
      'mhinz/vim-startify',
      config = function() require('plugins.startify') end
    }
    use('wellle/targets.vim') -- adds text-objects to work with (like 'ci,' for example))
    use('tpope/vim-repeat') -- .
    use('rhysd/clever-f.vim') -- Better (visual) f, F, t and T motion

    use{ -- vsnip
      'hrsh7th/vim-vsnip',
      requires = {'hrsh7th/vim-vsnip-integ'},
      config = function()
        require('plugins.vsnip')
      end
    }

    use{ -- cmp
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-vsnip'
      },
      config = function()
        require('plugins.cmp')
      end
    }

    use{ -- FixCursorHold
      'antoinemadec/FixCursorHold.nvim',
      config = function()
        vim.g.cursorhold_updatetime = 100
      end
    }

    use{ -- todo-comments.nvim
      'folke/todo-comments.nvim',
      config = function()
        require('todo-comments').setup()
      end
    }
  end

  local function interface()
    use{ -- gitsigns.nvim
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    use{'godlygeek/tabular', opt = true, cmd = {'Tabularize'}} -- Tabularize everything
    use('kyazdani42/nvim-web-devicons')
    use{ -- Ctrlsf Search and replace interface
      'dyng/ctrlsf.vim',
      config = function()
        vim.g['ctrlsf_populate_qflist'] = true
        --vim.g['ctrlsf_default_view_mode'] = 'compact'
      end
    }

    use{ -- colorizer
      'norcalli/nvim-colorizer.lua',
      config = function() require('plugins.colorizer') end
    }

    use{ -- Telescope
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('plugins.telescope').init()
      end
    }

    use{ -- lualine
      'nvim-lualine/lualine.nvim',
      config = function() require('plugins.lualine') end
    }

    use{ -- bufferline
      'akinsho/nvim-bufferline.lua',
      branch = 'main',
      config = function()
        require('plugins.bufferline').init()
      end
    }

    use{ -- indent-blankline
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugins.indent_blankline')
      end
    }

    use{ -- dressing.nvim
      'stevearc/dressing.nvim',
      config = function() require('plugins.dressing') end
    }

    use{ -- notify
      'rcarriga/nvim-notify',
      config = function()
        require('plugins.notify')
      end
    }

    use{ -- vim-illuminate
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
    }
  end

  local function themes()
    use{'Luxed/ayu-vim'}
  end

  local function lsp_dap()
    use { -- lspconfig
      'neovim/nvim-lspconfig',
      requires = {
        'mfussenegger/nvim-jdtls',
        'nvim-lua/lsp-status.nvim',
        'Hoffs/omnisharp-extended-lsp.nvim',
        'onsails/lspkind-nvim',
        'kosayoda/nvim-lightbulb',
        'simrat39/rust-tools.nvim',
        'ray-x/lsp_signature.nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils',

        -- LSP installer
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
      },
      config = function()
        require('plugins.lsp_status')
        require('plugins.lsp')
      end
    }

    if vim.fn.has('nvim-0.8') == 1 then
      use{ -- inc-rename
        'smjonas/inc-rename.nvim',
        config = function() require('inc_rename').setup() end
      }

      use{ -- neodim
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = function() require('plugins.dim') end
      }
    end

    use{ -- dap
      'mfussenegger/nvim-dap',
      requires = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text'
      },
      config = function() require('plugins.dap') end
    }
  end

  local function tracking()
    use{'ActivityWatch/aw-watcher-vim', opt = true}
  end

  languages()
  utility()
  interface()
  themes()
  lsp_dap()
  tracking()
end

local first_install = bootstrap()
vim.g['first_install'] = first_install
require('packer').startup(startup)

if first_install then
  print('First install. Plugins will be automatically installed.')
  print('Restart Neovim once the update is fully finished')
  require('packer').sync()
end
