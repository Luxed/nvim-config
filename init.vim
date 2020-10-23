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

" {{{ vsnip
imap <expr> <C-e> vsnip#expandable() ?
            \ '<Plug>(vsnip-expand)' :
            \ '<C-e>'
smap <expr> <C-e> vsnip#expandable() ?
            \ '<Plug>(vsnip-expand)' :
            \ '<C-e>'

imap <expr> <C-j> vsnip#jumpable(1) ?
            \ '<Plug>(vsnip-jump-next)' :
            \ '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1) ?
            \ '<Plug>(vsnip-jump-next)' :
            \ '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ?
            \ '<Plug>(vsnip-jump-prev)' :
            \ '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ?
            \ '<Plug>(vsnip-jump-prev)' :
            \ '<C-k>'
" }}}

" {{{ completion-nvim
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_timer_cycle = 40
let g:completion_matching_strategy_list = ['exact', 'fuzzy']
"let g:completion_sorting = "none"
" same as coc.nvim ?
let g:completion_sorting = "length"
let g:completion_chain_complete_list = {
            \ 'default': [
            \       { 'complete_items': ['lsp', 'snippet', 'path'] },
            \       { 'mode': '<c-p>' },
            \       { 'mode': '<c-n>' }
            \ ]
            \}
" Remap CR to allow auto pairs plugin to work
let g:completion_confirm_key = ""
imap <expr> <CR> pumvisible() ?
            \ complete_info()["selected"] != "-1" ?
            \ "\<Plug>(completion_confirm_completion)" :
            \ "\<c-e><CR>" :
            \ "\<CR>"
inoremap <silent><expr> <c-space> completion#trigger_completion()
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
" }}}

" {{{ lsp (builtin)
nnoremap <silent> <leader>qk <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>qK <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>qq <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> <leader>qgr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>qgd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>qgi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>qr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>qa <cmd>lua vim.lsp.buf.code_action()<CR>
" }}}

" {{{ lsp (diagnostic-nvim)
nnoremap <leader>qn <cmd>NextDiagnosticCycle<CR>
nnoremap <leader>qp <cmd>PrevDiagnosticCycle<CR>
nnoremap <leader>qd <cmd>OpenDiagnostic<CR>

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '
"let g:diagnostic_trimmed_virtual_text = '70'
let g:space_before_virtual_text = 5
let g:diagnostic_insert_delay = 1
" }}}

lua require('init')

augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = { 'jdtls' }})
augroup end

filetype plugin indent on
