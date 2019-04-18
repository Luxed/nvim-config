if has('unix')
    source ~/.config/nvim/00_vanilla.vim
    source ~/.config/nvim/01_plugins.vim
    source ~/.config/nvim/02_pluginsConf.vim
elseif has('win32')
    let g:python_host_prog = 'C:\Python27\python.exe'
    let g:python3_host_prog = 'C:\Program Files\Python37\python.exe'
    source $HOME\AppData\Local\nvim\00_vanilla.vim
    "source $HOME\AppData\Local\nvim\01_plugins.vim
    source $HOME\AppData\Local\nvim\01_plugins_dein.vim
    source $HOME\AppData\Local\nvim\02_pluginsConf.vim
endif

" ===          Post init           ===
" Themes are loaded last to avoid any issues
set t_Co=256 " Force terminal colors to be 256 (fallback in case the terminal used doesn't accept TrueColor)
set termguicolors " Sets the colors of the terminal to work as Truecolor (gui colors)
set background=dark
colorscheme deus

" Remove issues on ShellInABox and Butterfly terminal
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
