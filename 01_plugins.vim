" Plugins initialization
call plug#begin()

" -- Languages
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown' " used mainly for the TableFormat command
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-markdownfootnotes'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'udalov/kotlin-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'hspec/Hspec.vim'
Plug 'junegunn/vader.vim'
Plug 'vim-python/python-syntax'
"Plug 'leafgarland/typescript-vim'
Plug 'herringtondarkholme/yats.vim' " Typescript syntax
"Plug 'mhartington/nvim-typescript'
Plug 'https://github.com/PProvost/vim-ps1'

" -- Syntax/Error checker
" NOTE: Consider testing 'autozimu/LanguageClient-neovim' as an LSP
" alternative
Plug 'w0rp/ale'

" Auto Completion
Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim' " Code completion
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-jedi' " Python completion

" -- Utility
Plug 'tpope/vim-fugitive' " Git integration
Plug 'jiangmiao/auto-pairs' " Automatic mathing of pairs (like (, ' or {)
"Plug 'raimondi/delimitmate'
Plug 'alvan/vim-closetag' " Auto close html tags
Plug 'scrooloose/nerdtree' " File explorer
Plug 'scrooloose/nerdcommenter' " Commenting tool
Plug 'majutsushi/tagbar' " Ctags visual integration
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file searcher
Plug 'tpope/vim-surround' " Surround (visually select and surround with what you want)
Plug 'Luxed/vim-markdown-preview', { 'branch': 'firefox-quantum' } " Realtime live preview of a rendered pandoc markdown file
Plug 'tmhedberg/simpylfold' " Python code folding
Plug 'AndrewRadev/bufferize.vim' " Execute commands in a buffer
"Plug 'andrewradev/splitjoin.vim' " Looks great, needs testing
"Plug 'mhinz/vim-startify'
Plug 'matze/vim-move'
Plug 'sickill/vim-pasta'
Plug 'wellle/targets.vim' " adds text-objects to work with (with 'ci,' for example))
Plug 'tpope/vim-repeat'

" Interface
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify' " Version control gutter signs (git, svn, mercurial, etc.)
Plug 'godlygeek/tabular' " Auto spaces on what you choose (on '=' for example while declaring variables)
"Plug 'yuttie/comfortable-motion.vim' " Causes visual glitches with the
"butterfly terminal
if has('unix')
    Plug 'ryanoasis/vim-devicons' " Needs a patched font
endif
" Distraction free writing (works well in markdown)
Plug 'junegunn/limelight.vim' " :Limelight allows you to focus on blocks in markdown
Plug 'junegunn/goyo.vim'
"Plug 'valloric/matchtagalways' " Match HTML, and XML like tags
"Plug 'andymass/vim-matchup' " Seems interesting, don't know how to use it
Plug 'henrik/vim-indexed-search'
"Plug 'Yggdroot/indentLine'

" Themes
Plug 'flazz/vim-colorschemes'
Plug 'iCyMind/NeoSolarized'
Plug 'reedes/vim-colors-pencil'
Plug 'ajmwagar/vim-deus' " Gruvbox based
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}

call plug#end()
