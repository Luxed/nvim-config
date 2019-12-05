" Config that doesn't load any plugins
let g:minimal_config = 1

let g:config_path = expand('<sfile>:p:h')

execute 'source ' . g:config_path . '/00_vanilla.vim'

let system_config_path = g:config_path . '/system_config.vim'

if filereadable(system_config_path)
    execute 'source ' . system_config_path
endif

set t_Co=256
set termguicolors
set background=dark
colorscheme desert
