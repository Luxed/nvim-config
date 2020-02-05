let g:minimal_config = 0
let g:config_path = fnamemodify($MYVIMRC, ':h')

execute 'source ' . g:config_path . '/00_vanilla.vim'
execute 'source ' . g:config_path . '/01_plugins_dein.vim'
execute 'source ' . g:config_path . '/02_pluginsConf.vim'

" Execute lua's entry point
lua require('bootstrap')

let system_config_path = g:config_path . '/system_config.vim'

if filereadable(system_config_path)
    execute 'source ' . system_config_path
endif

" ===          Post init           ===
" Themes are loaded last to avoid any issues
set t_Co=256 " Force terminal colors to be 256 (fallback in case the terminal used doesn't accept TrueColor)
set termguicolors " Sets the colors of the terminal to work as Truecolor (gui colors)
"set background=dark
let ayucolor = 'mirage'
colorscheme nord

" Remove issues on ShellInABox and Butterfly terminal
set guicursor=
