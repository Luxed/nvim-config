" Path to dein.vim
let g:dein_path = g:config_path . '/dein'

let g:dein_plugin_path = g:dein_path . '/repos/github.com/Shougo/dein.vim'

let dein_installed = v:false

if !isdirectory(g:dein_plugin_path)
    execute '!git clone https://github.com/Shougo/dein.vim ' . g:dein_plugin_path
    let dein_installed = v:true
endif

execute 'set runtimepath+=' . g:dein_plugin_path

if dein#load_state(g:dein_path)
    call dein#begin(g:dein_path)

    call dein#add('Shougo/dein.vim')

    call dein#add('roxma/nvim-yarp')

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
    call dein#add('heavenshell/vim-jsdoc')
    "call dein#add('othree/jsdoc-syntax.vim')
    "call dein#add('othree/yajs.vim')
    call dein#add('othree/html5.vim')
    call dein#add('tikhomirov/vim-glsl')
    call dein#add('udalov/kotlin-vim')
    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('hspec/Hspec.vim')
    call dein#add('junegunn/vader.vim')
    call dein#add('numirias/semshi') " Python semantic syntax highlighting
    call dein#add('tmhedberg/simpylfold') " Python code folding
    call dein#add('herringtondarkholme/yats.vim') " Typescript syntax
    call dein#add('PProvost/vim-ps1')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('reasonml-editor/vim-reason-plus')

    " }}}

    " {{{ Syntax/Error checker

    call dein#add('w0rp/ale')

    " }}}

    " {{{ Auto Completion

    call dein#add('sirver/ultisnips')
    call dein#add('honza/vim-snippets')
    " * Deoplete setup
    "call dein#add('Shougo/deoplete.nvim') " Code completion
    " * ncm2 setup
    "call dein#add('ncm2/ncm2')
    "call dein#add('ncm2/ncm2-bufword')
    "call dein#add('ncm2/ncm2-path')
    "call dein#add('ncm2/ncm2-ultisnips')
    "call dein#add('ncm2/ncm2-vim')
    " * Asyncomplete setup
    "call dein#add('prabirshrestha/asyncomplete.vim')
    "call dein#add('prabirshrestha/asyncomplete-buffer.vim')
    "call dein#add('prabirshrestha/asyncomplete-ultisnips.vim')
    "call dein#add('prabirshrestha/asyncomplete-file.vim')
    "call dein#add('andreypopp/asyncomplete-ale.vim')
    "call dein#add('prabirshrestha/asyncomplete-necovim.vim')
    " CoC setup
    call dein#add('neoclide/coc.nvim', {
                \ 'rev'    : 'release',
                \ 'merged' : 0
                \})
    call dein#add('neoclide/coc-sources')
    call dein#add('neoclide/coc-neco')
    call dein#add('iamcco/coc-vimlsp')
    call dein#add('neoclide/coc-rls')
    call dein#add('neoclide/coc-json')
    call dein#add('neoclide/coc-tsserver')
    call dein#add('neoclide/coc-prettier')
    call dein#add('neoclide/coc-css')
    call dein#add('neoclide/coc-html')
    call dein#add('neoclide/coc-emmet')
    call dein#add('iamcco/coc-angular')

    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/neco-vim')

    " }}}

    " {{{ Utility

    call dein#add('tpope/vim-fugitive') " Git integration
    call dein#add('junegunn/gv.vim')
    "call dein#add('raimondi/delimitmate') " Auto close things
    call dein#add('jiangmiao/auto-pairs') " Auto close things ('(', '{', '[', etc.)
    call dein#add('alvan/vim-closetag') " Auto close html tags
    call dein#add('scrooloose/nerdtree') " File explorer
    call dein#add('scrooloose/nerdcommenter') " Commenting tool
    "call dein#add('majutsushi/tagbar') " Ctags visual integration
    call dein#add('tpope/vim-surround') " Surround (visually select and surround with what you want)
    call dein#add('AndrewRadev/bufferize.vim') " Execute commands in a buffer
    call dein#add('andrewradev/splitjoin.vim') " Looks great, needs testing
    call dein#add('mhinz/vim-startify')
    call dein#add('wellle/targets.vim') " adds text-objects to work with (like 'ci,' for example))
    call dein#add('tpope/vim-repeat') " .
    call dein#add('Luxed/vim-switcher') " Switch between filetypes
    call dein#add('Shougo/denite.nvim') " Unite all interfaces
    call dein#add('Shougo/neomru.vim') " MRU for Denite
    call dein#add('raghur/fruzzy', {
                \ 'hook_post_update' : 'call fruzzy#install()',
                \ 'merged'           : 0
                \}) " Faster fuzzy search for Denite
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
    "call dein#add('junegunn/vim-peekaboo') " Show the contents of registers
    "call dein#add('valloric/matchtagalways') " Match HTML, and XML like tags
    call dein#add('henrik/vim-indexed-search')
    "call dein#add('Marslo/vim-coloresque') " Show me the colors

    " }}}

    " {{{ Themes

    call dein#add('flazz/vim-colorschemes')
    call dein#add('iCyMind/NeoSolarized')
    call dein#add('reedes/vim-colors-pencil')
    call dein#add('ajmwagar/vim-deus') " Gruvbox based
    call dein#add('aonemd/kuroi.vim')
    " call dein#add('challenger-deep-theme/vim', {'as': 'challenger-deep'}
    call dein#add('dracula/vim', {'name': 'dracula-git'})

    " }}}

    call dein#end()
    call dein#save_state()
endif

if dein_installed == v:true
    call dein#install()
endif

" Load filetype-specific indent files
filetype plugin indent on
