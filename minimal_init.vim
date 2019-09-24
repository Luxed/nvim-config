" Config that doesn't load any plugins
let g:minimal_config = 1

echo expand('<sfile>:p:h')

let g:config_path = expand('<sfile>:p:h')

execute 'source ' . g:config_path . '/00_vanilla.vim'

let system_config_path = g:config_path . '/system_config.vim'

set t_Co=256
set termguicolors
set background=dark
colorscheme desert
