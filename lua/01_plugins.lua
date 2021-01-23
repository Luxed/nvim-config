local au = require('helpers.command').autocmd

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

-- TODO: look into properly managing dependencies
local function startup(use)
  use({'wbthomason/packer.nvim', opt = true})

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
    use('reasonml-editor/vim-reason-plus')
    use('herringtondarkholme/yats.vim') -- Typescript syntax
    use('posva/vim-vue')
    -- Html
    use('othree/html5.vim')
    use('hail2u/vim-css3-syntax')
    use('cakebaker/scss-syntax.vim')
    -- Glsl
    use('tikhomirov/vim-glsl')
    -- Kotlin
    use('udalov/kotlin-vim')
    -- Haskell
    use('neovimhaskell/haskell-vim')
    use('hspec/Hspec.vim')
    -- Vimscript
    use('junegunn/vader.vim')
    -- Python
    use('numirias/semshi') -- Python semantic syntax highlighting
    use('tmhedberg/simpylfold') -- Python code folding
    -- Shell
    use('PProvost/vim-ps1')
    use('blankname/vim-fish')
    -- Lua
    use('tbastos/vim-lua')
    -- the following give me worse folding with syntax fold activated
    --use('euclidianAce/BetterLua.vim')
    --use('tjdevries/manillua.nvim')
    use('leafo/moonscript-vim')
    use('bakpakin/fennel.vim')
    -- C#
    --use('OmniSharp/omnisharp-vim')
  end

  local function utility()
    use('tpope/vim-fugitive') -- Git integration
    use('junegunn/gv.vim') -- Git log graphical visualisation
    use('jiangmiao/auto-pairs') -- Auto close things ('(', '{', '[', etc.)
    use('alvan/vim-closetag') -- Auto close html tags
    use('scrooloose/nerdtree') -- File explorer
    use('scrooloose/nerdcommenter') -- Commenting tool
    use('tpope/vim-surround') -- Surround (visually select and surround with what you want)
    use('AndrewRadev/bufferize.vim') -- Execute commands in a buffer
    use('andrewradev/splitjoin.vim') -- Better split and join (gS, gJ)
    use('mhinz/vim-startify') -- Nice startup screen
    use('wellle/targets.vim') -- adds text-objects to work with (like 'ci,' for example))
    use('tpope/vim-repeat') -- .
    use('machakann/vim-highlightedyank') -- highlights what's been yanked, TODO: replace with built-in neovim `on_yank`
    use('mattn/emmet-vim')
    use('rhysd/clever-f.vim') -- Better (visual) f, F, t and T motion
  end

  local function interface()
    --use('vim-airline/vim-airline') -- Status bar + tabline
    --use('vim-airline/vim-airline-themes')
    use('mhinz/vim-signify') -- Version control gutter signs (git, svn, mercurial, etc.)
    use('godlygeek/tabular') -- Tabularize everything
    use('ryanoasis/vim-devicons') -- Needs a patched font
    use('kyazdani42/nvim-web-devicons')
    --use('junegunn/rainbow_parentheses.vim')
    use('dyng/ctrlsf.vim') -- Search and replace interface
    use('f-person/git-blame.nvim') -- Simple, virtual text, git blame
  end

  local function themes()
    use('iCyMind/NeoSolarized')
    use('reedes/vim-colors-pencil')
    use('ajmwagar/vim-deus') -- Gruvbox based
    use('aonemd/kuroi.vim')
    use({'dracula/vim', as = 'dracula'})
    use('jacoborus/tender.vim')
    use('arcticicestudio/nord-vim')
    use('ayu-theme/ayu-vim')
    use('zeis/vim-kolor')
    use('danilo-augusto/vim-afterglow')
    use('cseelus/vim-colors-lucid')
    use('bluz71/vim-nightfly-guicolors')
    use('srcery-colors/srcery-vim')
    use({'embark-theme/vim', as = 'embark'})
    use('sainnhe/sonokai')
    use('glepnir/zephyr-nvim')
  end

  local function lua_plugins()
    -- TODO: look into replacing this by snippets.nvim
    use('hrsh7th/vim-vsnip')
    use('hrsh7th/vim-vsnip-integ')

    use('norcalli/nvim-colorizer.lua')

    -- Telescope (fuzzy finder)
    use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/telescope.nvim')

    -- TreeSitter
    use('nvim-treesitter/nvim-treesitter')
    use('nvim-treesitter/nvim-treesitter-refactor')
    use('p00f/nvim-ts-rainbow')

    -- LSP related plugins
    use('neovim/nvim-lspconfig')
    use('tjdevries/nlua.nvim')
    use('mfussenegger/nvim-jdtls')

    -- Completion
    use('nvim-lua/completion-nvim')
    -- use('steelsoja/completion-buffers')

    -- Statusline/Tabline
    use('glepnir/galaxyline.nvim')
    use('akinsho/nvim-bufferline.lua')
  end

  local function tracking()
    use({'ActivityWatch/aw-watcher-vim', opt = true})
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
  vim.cmd('PackerSync')
end

au('bufWritePost', 'plugins.lua', 'PackerCompile')
