" === Load vanilla (neo)vim config ===
source ~/.config/nvim/00_vanilla.vim

" === Load plugins (with vim-plug) ===
source ~/.config/nvim/01_plugins.vim

" === Load plugins configurations  ===
" TODO: Make different ftplugins files into a configurable plugin to have easy
" 'run', 'build' and 'test'
source ~/.config/nvim/02_pluginsConf.vim

" ===          Post init           ===
" Themes are loaded last to avoid any issues
set t_Co=256 " Force terminal colors to be 256 (fallback in case the terminal used doesn't accept TrueColor)
set termguicolors " Sets the colors of the terminal to work as Truecolor (gui colors)
set background=dark
colorscheme deus

" Remove issues on ShellInABox and Butterfly terminal
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
