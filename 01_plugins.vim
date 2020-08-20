" Path to minpac
let g:minpac_plugin_path = g:config_path . '/pack/minpac/opt/minpac'

function! PackInit() abort
    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    call minpac#add('roxma/nvim-yarp')

    " {{{ Languages

    " Rust
    call minpac#add('rust-lang/rust.vim')
    " Markdown
    call minpac#add('vim-pandoc/vim-pandoc')
    call minpac#add('vim-pandoc/vim-pandoc-syntax')
    call minpac#add('vim-pandoc/vim-markdownfootnotes')
    " File Format
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('mboughaba/i3config.vim')
    call minpac#add('elzr/vim-json')
    call minpac#add('cespare/vim-toml')
    " Javascript, Typescript
    call minpac#add('pangloss/vim-javascript')
    call minpac#add('heavenshell/vim-jsdoc')
    call minpac#add('reasonml-editor/vim-reason-plus')
    call minpac#add('herringtondarkholme/yats.vim') " Typescript syntax
    call minpac#add('posva/vim-vue')
    " Html
    call minpac#add('othree/html5.vim')
    call minpac#add('hail2u/vim-css3-syntax')
    call minpac#add('cakebaker/scss-syntax.vim')
    " Glsl
    call minpac#add('tikhomirov/vim-glsl')
    " Kotlin
    call minpac#add('udalov/kotlin-vim')
    " Haskell
    call minpac#add('neovimhaskell/haskell-vim')
    call minpac#add('hspec/Hspec.vim')
    " Vimscript
    call minpac#add('junegunn/vader.vim')
    " Python
    call minpac#add('numirias/semshi') " Python semantic syntax highlighting
    call minpac#add('tmhedberg/simpylfold') " Python code folding
    " Scripting
    call minpac#add('PProvost/vim-ps1')
    " Lua
    call minpac#add('tbastos/vim-lua')
    call minpac#add('leafo/moonscript-vim')
    call minpac#add('bakpakin/fennel.vim')
    " C#
    call minpac#add('OmniSharp/omnisharp-vim')

    " }}}

    " {{{ Syntax, LSP, Completion, Linters

    " ALE
    call minpac#add('w0rp/ale')
    " Snippets
    call minpac#add('sirver/ultisnips')
    call minpac#add('honza/vim-snippets')
    " coc
    call minpac#add('neoclide/coc.nvim', { 'branch' : 'release' })
    call minpac#add('neoclide/coc-sources')
    call minpac#add('neoclide/coc-neco')
    " neco
    call minpac#add('Shougo/neco-syntax')
    call minpac#add('Shougo/neco-vim')

    " }}}

    " {{{ Utility

    call minpac#add('tpope/vim-fugitive') " Git integration
    call minpac#add('junegunn/gv.vim') " Git log graphical visualisation
    call minpac#add('jiangmiao/auto-pairs') " Auto close things ('(', '{', '[', etc.)
    call minpac#add('alvan/vim-closetag') " Auto close html tags
    call minpac#add('scrooloose/nerdtree') " File explorer
    call minpac#add('scrooloose/nerdcommenter') " Commenting tool
    call minpac#add('tpope/vim-surround') " Surround (visually select and surround with what you want)
    call minpac#add('AndrewRadev/bufferize.vim') " Execute commands in a buffer
    call minpac#add('andrewradev/splitjoin.vim') " Looks great, needs testing
    call minpac#add('mhinz/vim-startify') " Nice startup screen
    call minpac#add('wellle/targets.vim') " adds text-objects to work with (like 'ci,' for example))
    call minpac#add('tpope/vim-repeat') " .
    call minpac#add('Luxed/vim-switcher') " Switch between filetypes, TODO: delete repo and move to config files directly
    call minpac#add('machakann/vim-highlightedyank') " highlights what's been yanked
    call minpac#add('mattn/emmet-vim')
    call minpac#add('rhysd/clever-f.vim') " Better (visual) f, F, t and T motion
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('olical/aniseed')
    call minpac#add('Olical/nvim-local-fennel')
    call minpac#add('brooth/far.vim')

    " }}}

    " {{{ Interface

    call minpac#add('vim-airline/vim-airline') " Status bar + tabline
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('mhinz/vim-signify') " Version control gutter signs (git, svn, mercurial, etc.)
    call minpac#add('godlygeek/tabular') " Tabularize everything
    call minpac#add('ryanoasis/vim-devicons') " Needs a patched font
    call minpac#add('henrik/vim-indexed-search')
    call minpac#add('junegunn/rainbow_parentheses.vim')

    " }}}

    " {{{ Themes

    call minpac#add('iCyMind/NeoSolarized')
    call minpac#add('reedes/vim-colors-pencil')
    call minpac#add('ajmwagar/vim-deus') " Gruvbox based
    call minpac#add('aonemd/kuroi.vim')
    call minpac#add('dracula/vim', {'name': 'dracula-git'})
    call minpac#add('jacoborus/tender.vim')
    call minpac#add('arcticicestudio/nord-vim')
    call minpac#add('ayu-theme/ayu-vim')
    call minpac#add('zeis/vim-kolor')
    call minpac#add('danilo-augusto/vim-afterglow')
    call minpac#add('cseelus/vim-colors-lucid')
    call minpac#add('bluz71/vim-nightfly-guicolors')

    " }}}
endfunction

if !isdirectory(g:minpac_plugin_path)
    execute '!git clone https://github.com/k-takata/minpac.git ' . g:minpac_plugin_path
    call PackInit()
    call minpac#update()
endif

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" Load filetype-specific indent files
filetype plugin indent on