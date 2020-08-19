" Path to minpac
let g:minpac_plugin_path = g:config_path . '/pack/minpac/opt/minpac'

function! PackInit() abort
    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    call minpac#add('roxma/nvim-yarp')

    " {{{ Languages

    call minpac#add('rust-lang/rust.vim')
    call minpac#add('vim-pandoc/vim-pandoc')
    call minpac#add('vim-pandoc/vim-pandoc-syntax')
    call minpac#add('vim-pandoc/vim-markdownfootnotes')
    call minpac#add('elzr/vim-json')
    call minpac#add('cespare/vim-toml')
    call minpac#add('pangloss/vim-javascript')
    call minpac#add('heavenshell/vim-jsdoc')
    call minpac#add('othree/html5.vim')
    call minpac#add('hail2u/vim-css3-syntax')
    call minpac#add('cakebaker/scss-syntax.vim')
    call minpac#add('tikhomirov/vim-glsl')
    call minpac#add('udalov/kotlin-vim')
    call minpac#add('neovimhaskell/haskell-vim')
    call minpac#add('hspec/Hspec.vim')
    call minpac#add('junegunn/vader.vim')
    call minpac#add('numirias/semshi') " Python semantic syntax highlighting
    call minpac#add('tmhedberg/simpylfold') " Python code folding
    call minpac#add('herringtondarkholme/yats.vim') " Typescript syntax
    call minpac#add('PProvost/vim-ps1')
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('reasonml-editor/vim-reason-plus')
    call minpac#add('tbastos/vim-lua')
    call minpac#add('leafo/moonscript-vim')
    call minpac#add('bakpakin/fennel.vim')
    call minpac#add('posva/vim-vue')
    call minpac#add('OmniSharp/omnisharp-vim')
    call minpac#add('mboughaba/i3config.vim')

    " }}}

    " {{{ Syntax/Error checker

    call minpac#add('w0rp/ale')

    " }}}

    " {{{ Auto Completion

    call minpac#add('sirver/ultisnips')
    call minpac#add('honza/vim-snippets')

    " CoC setup
    call minpac#add('neoclide/coc.nvim', { 'rev' : 'release' })
    call minpac#add('neoclide/coc-sources')
    call minpac#add('neoclide/coc-neco')

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
    call minpac#add('olical/aniseed', { 'rev': 'master' })
    call minpac#add('Olical/nvim-local-fennel', {'rev': 'master'})
    call minpac#add('brooth/far.vim')

    " }}}

    " {{{ Themes

    call minpac#add('iCyMind/NeoSolarized')
    call minpac#add('reedes/vim-colors-pencil')
    call minpac#add('ajmwagar/vim-deus') " Gruvbox based
    call minpac#add('aonemd/kuroi.vim')
    call minpac#add('dracula/vim', {'name': 'dracula-git'})
    call minpac#add('jacoborus/tender.vim')
    call minpac#add('herrbischoff/cobalt2.vim')
    call minpac#add('arcticicestudio/nord-vim')
    call minpac#add('ayu-theme/ayu-vim')
    call minpac#add('zeis/vim-kolor')
    call minpac#add('danilo-augusto/vim-afterglow')
    call minpac#add('cseelus/vim-colors-lucid')
    call minpac#add('dikiaap/minimalist')
    call minpac#add('bluz71/vim-nightfly-guicolors')

    " }}}
endfunction

if !isdirectory(g:minpac_plugin_path)
    execute '!git clone https://github.com/k-takata/minpac.git ' . g:minpac_plugin_path
    call PackInit()
    call minpac#update()
endif

" Load filetype-specific indent files
filetype plugin indent on
