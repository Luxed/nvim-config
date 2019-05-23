let g:config_path = fnamemodify($MYVIMRC, ':h')

execute 'source ' . g:config_path . '/00_vanilla.vim'
execute 'source ' . g:config_path . '/01_plugins_dein.vim'
execute 'source ' . g:config_path . '/02_pluginsConf.vim'

if has('win32')
    let g:python_host_prog = 'C:\Python27\python.exe'
    let g:python3_host_prog = 'C:\Python37\python.exe'
endif

" ===          Post init           ===
" Themes are loaded last to avoid any issues
set t_Co=256 " Force terminal colors to be 256 (fallback in case the terminal used doesn't accept TrueColor)
set termguicolors " Sets the colors of the terminal to work as Truecolor (gui colors)
set background=dark
colorscheme dracula

" Remove issues on ShellInABox and Butterfly terminal
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
