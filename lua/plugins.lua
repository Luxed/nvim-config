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
    -- Rust
    use('rust-lang/rust.vim')
    -- Markdown
    use {
      'vim-pandoc/vim-pandoc',
      requires = {'vim-pandoc/vim-pandoc-syntax', 'vim-pandoc/vim-markdownfootnotes'},
      config = function()
        vim.g['pandoc#modules#disabled'] = {'spell'}
      end
    }
    -- File Format
    use('editorconfig/editorconfig-vim')
    use('mboughaba/i3config.vim')
    use('cespare/vim-toml')
    -- Vue
    use('posva/vim-vue')
    -- Glsl
    use('tikhomirov/vim-glsl')
    -- Kotlin
    use('udalov/kotlin-vim')
    -- Haskell
    use('neovimhaskell/haskell-vim')
    use{'hspec/Hspec.vim', opt=true, ft={'haskell'}}
    -- Vimscript
    use('junegunn/vader.vim')
    -- Shell
    use('PProvost/vim-ps1')
    use('blankname/vim-fish')
    -- Reason
    use('rescript-lang/vim-rescript')

    use{'openembedded/bitbake', rtp = 'contrib/vim'}
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
    use{ -- Fern: file manager
      'lambdalisue/fern.vim',
      requires = {
        'lambdalisue/nerdfont.vim',
        'lambdalisue/fern-renderer-nerdfont.vim',
        'lambdalisue/fern-git-status.vim'
      },
      config = function() require('plugins.fern') end
    }
    use('preservim/nerdcommenter') -- Commenting tool
    use('tpope/vim-surround') -- Surround (visually select and surround with what you want)
    use{'AndrewRadev/bufferize.vim', opt = true, cmd = {'Bufferize'}} -- Execute commands in a buffer
    use{'andrewradev/splitjoin.vim', branch = 'main'} -- Better split and join (gS, gJ)
    use{ -- Startify: Nice startup screen
      'mhinz/vim-startify',
      config = function() require('plugins.startify') end
    }
    use('wellle/targets.vim') -- adds text-objects to work with (like 'ci,' for example))
    use('tpope/vim-repeat') -- .
    --use{'mattn/emmet-vim', opt = true, ft={'html'}}
    use('rhysd/clever-f.vim') -- Better (visual) f, F, t and T motion
  end

  local function interface()
    use('mhinz/vim-signify') -- Version control gutter signs (git, svn, mercurial, etc.)
    use{'godlygeek/tabular', opt = true, cmd = {'Tabularize'}} -- Tabularize everything
    use('kyazdani42/nvim-web-devicons')
    use{ -- Search and replace interface
      'dyng/ctrlsf.vim',
      config = function()
        vim.g['ctrlsf_populate_qflist'] = true
        --vim.g['ctrlsf_default_view_mode'] = 'compact'
      end
    }
  end

  local function themes()
    use{'Luxed/ayu-vim', branch = 'experimental-colors'}
  end

  local function lua_plugins()
    use{ -- vsnip
      'hrsh7th/vim-vsnip',
      requires = {'hrsh7th/vim-vsnip-integ'},
      config = function()
        require('plugins.vsnip')
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

    use { -- TreeSitter
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/playground'
      },
      config = function()
        require('plugins.treesitter')
      end
    }

    use { -- lspconfig
      'neovim/nvim-lspconfig',
      requires = {
        'tjdevries/nlua.nvim',
        'mfussenegger/nvim-jdtls',
        'nvim-lua/lsp-status.nvim',
        'Hoffs/omnisharp-extended-lsp.nvim',
        'simrat39/rust-tools.nvim',
        'williamboman/nvim-lsp-installer'
      },
      config = function()
        require('plugins.lsp_status')
        require('plugins.lsp')
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

    use{'kosayoda/nvim-lightbulb'}

    use{ -- galaxyline
      'NTBBloodbath/galaxyline.nvim',
      config = function()
        require('plugins.galaxyline')
      end
    }
    use{ -- bufferline
      'akinsho/nvim-bufferline.lua',
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

    use('ray-x/lsp_signature.nvim')

    use('jose-elias-alvarez/nvim-lsp-ts-utils')
  end

  local function tracking()
    use{'ActivityWatch/aw-watcher-vim', opt = true}
  end

  languages()
  utility()
  interface()
  themes()
  lua_plugins()
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
