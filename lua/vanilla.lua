local map = require('helpers.map')
local command = require('helpers.command').command
local augroup = require('helpers.command').augroup

local default_indent = 4

vim.opt.tabstop = default_indent
vim.opt.softtabstop = default_indent
vim.opt.expandtab = true
vim.opt.shiftwidth = default_indent
vim.opt.autoindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:2'
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'

vim.opt.showbreak = '> '
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.mouse = 'a'
vim.opt.cmdheight = 2
vim.opt.inccommand = 'nosplit'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autowrite = true
vim.opt.updatetime = 300
vim.opt.termguicolors = true
vim.opt.grepprg = 'rg --no-heading --vimgrep --smart-case'
vim.opt.hidden = true
--vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.completeopt = 'menu,menuone,noselect'

vim.opt.shortmess:append('c')
vim.opt.diffopt:append('algorithm:patience')

vim.g.mapleader = ','

map.nnore(';', ':')
map.nnore('<leader>l', ':bnext<CR>')
map.nnore('<leader>h', ':bprevious<CR>')
map.nnore('<leader>bq', ':b# <BAR> bd #<CR>')

map.lua('n', 'zS', function() require('helpers.syntax').showCursorHighlights() end)

-- toggle highlight
map.nnore('<leader>th', ':set hlsearch!<CR>')
map.nnore('<leader>tw', ':setlocal wrap!<CR>')
map.nnore('<leader>n', ':nohl<CR>')
map.nnore('<leader>N', ':Rmhl<CR>')
-- Removes last highlight
command('Rmhl', ':let @/=""')

-- Folds keybinds
map.n('<space>', 'za', {})
map.n('<C-space>', 'zA', {})

map.tnore('<leader>n', '<C-\\><C-N>')

if vim.fn.has('win32') == 1 then
  -- Because Windows is such a great operating system, doing <C-Z> will completely lock up Neovim in the terminal. see: https://github.com/neovim/neovim/issues/6660
  map.lua('n', '<C-Z>', function() require('term').open() end)
end

-- Switch
map.nnore('<leader>ss', ':call switcher#Switch()<CR>')
map.nnore('<leader>sv', ':call switcher#SwitchWithOptions({"edit_command": "vs"})<CR>')
map.nnore('<leader>sh', ':call switcher#SwitchWithOptions({"edit_command": "sp"})<CR>')

-- Wrap
map.xnore('<leader>w', ':call wrap#func()<CR>')

command('DeleteHiddenBuffers', 'call buffers#delete_all_hidden()')

augroup('yank_post_highlight', {
    { 'TextYankPost', '*', 'silent! lua vim.highlight.on_yank{timeout=500}' }
  })

command('-nargs=1 YarnS', 'sp term://yarn <args>');

command('Term', 'lua require("term").open()')
