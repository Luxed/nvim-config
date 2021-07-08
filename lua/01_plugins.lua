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

  -- TODO: A lot of things in there could be removed thanks to TreeSitter.
  local function languages()
    -- Rust
    use('rust-lang/rust.vim')
    -- Markdown
    use('vim-pandoc/vim-pandoc')
    use('vim-pandoc/vim-pandoc-syntax')
    use('vim-pandoc/vim-markdownfootnotes')
    -- File Format
    use('editorconfig/editorconfig-vim')
    use('mboughaba/i3config.vim')
    use('elzr/vim-json')
    use('cespare/vim-toml')
    -- Javascript, Typescript
    use('pangloss/vim-javascript')
    use('heavenshell/vim-jsdoc')
    --use('reasonml-editor/vim-reason-plus')
    use('herringtondarkholme/yats.vim') -- Typescript syntax
    use('posva/vim-vue')
    -- Html/css
    use('othree/html5.vim')
    use('hail2u/vim-css3-syntax')
    use('cakebaker/scss-syntax.vim')
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
    -- Lua
    use('tbastos/vim-lua')
    use('leafo/moonscript-vim')
    use('bakpakin/fennel.vim')
    -- Reason
    use('rescript-lang/vim-rescript')
  end

  local function utility()
    use('tpope/vim-fugitive') -- Git integration
    use{'junegunn/gv.vim', opt = true, cmd = {'GV'}} -- Git log graphical visualisation
    use{'jiangmiao/auto-pairs', opt = true} -- Auto close things ('(', '{', '[', etc.)
    use{'windwp/nvim-autopairs', opt = true}
    use('alvan/vim-closetag') -- Auto close html tags
    --use('preservim/nerdtree') -- File explorer
    use{'lambdalisue/fern.vim', requires = {'lambdalisue/nerdfont.vim', 'lambdalisue/fern-renderer-nerdfont.vim'}}
    use('preservim/nerdcommenter') -- Commenting tool
    use('tpope/vim-surround') -- Surround (visually select and surround with what you want)
    use{'AndrewRadev/bufferize.vim', opt = true, cmd = {'Bufferize'}} -- Execute commands in a buffer
    use{'andrewradev/splitjoin.vim', branch = 'main'} -- Better split and join (gS, gJ)
    use('mhinz/vim-startify') -- Nice startup screen
    use('wellle/targets.vim') -- adds text-objects to work with (like 'ci,' for example))
    use('tpope/vim-repeat') -- .
    use{'mattn/emmet-vim', opt = true, ft={'html'}}
    use('rhysd/clever-f.vim') -- Better (visual) f, F, t and T motion
  end

  local function interface()
    use('mhinz/vim-signify') -- Version control gutter signs (git, svn, mercurial, etc.)
    use('godlygeek/tabular') -- Tabularize everything
    --use('ryanoasis/vim-devicons')
    --use('tiagofumo/vim-nerdtree-syntax-highlight')
    use('kyazdani42/nvim-web-devicons')
    use('dyng/ctrlsf.vim') -- Search and replace interface
    --use('f-person/git-blame.nvim') -- Simple, virtual text, git blame
  end

  local function themes()
    use('iCyMind/NeoSolarized')
    use('reedes/vim-colors-pencil')
    use('ajmwagar/vim-deus') -- Gruvbox based
    use('aonemd/kuroi.vim')
    use({'dracula/vim', as = 'dracula'})
    use('jacoborus/tender.vim')
    use('arcticicestudio/nord-vim')
    use{'Luxed/ayu-vim', branch = 'experimental-colors'}
    use('zeis/vim-kolor')
    use('danilo-augusto/vim-afterglow')
    use('cseelus/vim-colors-lucid')
    use('bluz71/vim-nightfly-guicolors')
    use('srcery-colors/srcery-vim')
    use({'embark-theme/vim', as = 'embark', branch = 'main'})
    use('sainnhe/sonokai')
    use('glepnir/zephyr-nvim')
  end

  local function lua_plugins()
    -- TODO: look into replacing this by snippets.nvim
    use{'hrsh7th/vim-vsnip', requires = {'hrsh7th/vim-vsnip-integ'}}

    use('norcalli/nvim-colorizer.lua')

    -- Telescope (fuzzy finder)
    use{'nvim-telescope/telescope.nvim', requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}}

    -- TreeSitter
    use {
      --'nvim-treesitter/nvim-treesitter',
      'Luxed/nvim-treesitter',
      branch = 'c_sharp',
      run = ':TSUpdate',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/playground'
      }
    }

    -- LSP related plugins
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'tjdevries/nlua.nvim',
        'mfussenegger/nvim-jdtls'
      }
    }
    use('nvim-lua/lsp-status.nvim')

    -- Completion
    use{'nvim-lua/completion-nvim', opt = true, requires = {'steelsojka/completion-buffers'}}
    use{'hrsh7th/nvim-compe', opt = true}

    -- Statusline/Tabline
    use('glepnir/galaxyline.nvim')
    use('akinsho/nvim-bufferline.lua')

    use({'lukas-reineke/indent-blankline.nvim', opt = true, branch = 'lua'})

    use('ray-x/lsp_signature.nvim')
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
require('packer').startup(startup)

if first_install then
  print('First install. Plugins will be automatically installed.')
  print('Restart Neovim once the update is fully finished')
  require('packer').sync()
end
