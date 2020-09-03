if &shell =~# 'fish$'
    " use a POSIX compatible terminal
    if filereadable('/bin/zsh')
        set shell=/bin/zsh
    elseif filereadable('/bin/bash')
        set shell=/bin/bash
    endif
endif

let g:minimal_config = 0
let g:config_path = fnamemodify($MYVIMRC, ':h')

execute 'source ' . g:config_path . '/00_vanilla.vim'
execute 'source ' . g:config_path . '/01_plugins.vim'
execute 'source ' . g:config_path . '/02_plugins_conf.vim'

let system_config_path = g:config_path . '/system_config.vim'
if filereadable(system_config_path)
    execute 'source ' . system_config_path
endif

let g:ayucolor = 'mirage'
colorscheme ayu

lua require('init')

xnoremap <leader>w :call wrap#func()<CR>
