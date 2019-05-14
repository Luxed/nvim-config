" Path to dein.vim
let g:dein_path = ''
if has('unix')
    let g:dein_path = '~/.config/nvim/dein'
elseif has('win32')
    let g:dein_path = g:config_path . '\dein'
endif

if g:dein_path == ''
    finish
else
    execute 'set runtimepath +=' . g:dein_path . '\repos\github.com\Shougo\dein.vim'
endif

if dein#load_state(g:dein_path)
    call dein#begin(g:dein_path)

    call dein#add('Shougo/dein.vim')

    "call dein#add('roxma/nvim-yarp')

    " {{{ Languages

    call dein#add('rust-lang/rust.vim')
    " TODO: Copy the TableFormat command from the plugin into my config
    " becaues it's really usefull but the plugin conflicts with vim-pandoc
    "call dein#add('plasticboy/vim-markdown') " used mainly for the TableFormat command
    call dein#add('vim-pandoc/vim-pandoc')
    call dein#add('vim-pandoc/vim-pandoc-syntax')
    call dein#add('vim-pandoc/vim-markdownfootnotes')
    call dein#add('elzr/vim-json')
    call dein#add('cespare/vim-toml')
    call dein#add('pangloss/vim-javascript')
    call dein#add('othree/html5.vim')
    call dein#add('tikhomirov/vim-glsl')
    call dein#add('udalov/kotlin-vim')
    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('hspec/Hspec.vim')
    call dein#add('junegunn/vader.vim')
    call dein#add('vim-python/python-syntax')
    call dein#add('herringtondarkholme/yats.vim') " Typescript syntax
    call dein#add('PProvost/vim-ps1')
    call dein#add('Shougo/neco-vim')

    " }}}

    " {{{ Syntax/Error checker

    " This should be all you ever need
    call dein#add('w0rp/ale')

    " }}}

    " {{{ Auto Completion

    "call dein#add('ervandew/supertab')
    call dein#add('sirver/ultisnips')
    call dein#add('honza/vim-snippets')
    " * Waiting for ALE to get deoplete support
    "call dein#add('Shougo/deoplete.nvim') " Code completion
    "call dein#add('sebastianmarkow/deoplete-rust') " Rust completion
    "call dein#add('zchee/deoplete-jedi') " Python completion
    " * ncm2 setup
    "call dein#add('ncm2/ncm2')
    "call dein#add('ncm2/ncm2-bufword')
    "call dein#add('ncm2/ncm2-path')
    "call dein#add('ncm2/ncm2-ultisnips')
    " * Asyncomplete setup
    call dein#add('prabirshrestha/asyncomplete.vim')
    call dein#add('prabirshrestha/asyncomplete-buffer.vim')
    call dein#add('prabirshrestha/asyncomplete-ultisnips.vim')
    call dein#add('prabirshrestha/asyncomplete-file.vim')
    call dein#add('andreypopp/asyncomplete-ale.vim')
    call dein#add('prabirshrestha/asyncomplete-necovim.vim')

    " }}}

    " {{{ Utility

    call dein#add('tpope/vim-fugitive') " Git integration
    "call dein#add('jiangmiao/auto-pairs') " Automatic mathing of pairs (like (, ' or {)
    call dein#add('raimondi/delimitmate')
    call dein#add('alvan/vim-closetag') " Auto close html tags
    call dein#add('scrooloose/nerdtree') " File explorer
    call dein#add('scrooloose/nerdcommenter') " Commenting tool
    call dein#add('majutsushi/tagbar') " Ctags visual integration
    call dein#add('ctrlpvim/ctrlp.vim') " Fuzzy file searcher
    call dein#add('tpope/vim-surround') " Surround (visually select and surround with what you want)
    call dein#add('Luxed/vim-markdown-preview') ", { 'branch': 'firefox-quantum' } Realtime live preview of a rendered pandoc markdown file
    call dein#add('tmhedberg/simpylfold') " Python code folding
    call dein#add('AndrewRadev/bufferize.vim') " Execute commands in a buffer
    call dein#add('andrewradev/splitjoin.vim') " Looks great, needs testing
    " TODO: Look into the customization of startify, maybe I can make it
    " better by changing options
    "call dein#add('mhinz/vim-startify')
    " TODO: Test vim-workspace
    "call dein#add('thaerkh/vim-workspace')
    "call dein#add('matze/vim-move') " Move lines or selections up and down
    "call dein#add('sickill/vim-pasta')
    call dein#add('wellle/targets.vim') " adds text-objects to work with (like 'ci,' for example))
    call dein#add('tpope/vim-repeat') " .
    call dein#add('Luxed/vim-switcher') " Switch between filetypes
    call dein#add('Shougo/denite.nvim', {'rev': 'ui'}) " Unite all interfaces
    call dein#add('raghur/fruzzy', {
                \ 'hook_post_update' : 'call fruzzy#install()',
                \ 'merged'           : 0
                \})
    call dein#add('machakann/vim-highlightedyank') " highlights what's been yanked
    call dein#add('mattn/emmet-vim')
    call dein#add('rhysd/clever-f.vim') " Better (visual) f, F, t and T motion

    " }}}

    " {{{ Interface

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('mhinz/vim-signify') " Version control gutter signs (git, svn, mercurial, etc.)
    call dein#add('godlygeek/tabular') " Auto spaces on what you choose (on '=' for example while declaring variables)
    call dein#add('ryanoasis/vim-devicons') " Needs a patched font
    " Distraction free writing (works well in markdown)
    call dein#add('junegunn/limelight.vim') " :Limelight allows you to focus on blocks in markdown
    call dein#add('junegunn/goyo.vim')
    "call dein#add('valloric/matchtagalways') " Match HTML, and XML like tags
    call dein#add('henrik/vim-indexed-search')
    call dein#add('Marslo/vim-coloresque') " Show me the colors

    " }}}

    " {{{ Themes

    call dein#add('flazz/vim-colorschemes')
    call dein#add('iCyMind/NeoSolarized')
    call dein#add('reedes/vim-colors-pencil')
    call dein#add('ajmwagar/vim-deus') " Gruvbox based
    call dein#add('aonemd/kuroi.vim')
    " call dein#add('challenger-deep-theme/vim', {'as': 'challenger-deep'}

    " }}}

    call dein#end()
    call dein#save_state()
endif

" Load filetype-specific indent files
filetype plugin indent on
