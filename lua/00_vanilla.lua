local set = require('helpers.set')
local map = require('helpers.map')
local command = require('helpers.command').command

local default_indent = 4
set('assign', {
  b = {
    tabstop = default_indent,
    softtabstop = default_indent,
    expandtab = true,
    shiftwidth = default_indent,
    -- TODO: Look into how the following works:
    -- smartindent = true
    autoindent = true
  },
  w = {
    wrap = true,
    linebreak = true,
    breakindent = true,
    breakindentopt = 'shift:2',
    number = true,
    cursorline = true,
    foldmethod = 'syntax',
    signcolumn = 'yes'
  },
  o = {
    showbreak = '> ',
    wildmenu = true,
    showcmd = true,
    lazyredraw = true,
    showmatch = true,
    incsearch = true,
    hlsearch = false,
    ruler = true,
    laststatus = 2,
    confirm = true,
    visualbell = true,
    mouse = 'a',
    cmdheight = 2,
    inccommand = 'nosplit',
    splitbelow = true,
    splitright = true,
    autowrite = true,
    updatetime = 300,
    termguicolors = true,
    grepprg = 'rg --no-heading --vimgrep --smart-case',
    hidden = true,
  }
})

set('increment', {
  o = {
    shortmess = 'c',
    diffopt = ',algorithm:patience'
  }
})

vim.g.mapleader = ','

map.nnore(';', ':')
map.nnore('<leader>l', ':bnext<CR>')
map.nnore('<leader>h', ':bprevious<CR>')
map.nnore('<leader>bq', ':b# <BAR> bd #<CR>')

map.nnore('<leader>ei', ':e $MYVIMRC<CR>')
map.nnore('<leader>si', ':source $MYVIMRC<CR>')

map.nnore('zS', ':lua print(require("helpers.syntax").getCursorHighlights())<CR>', {silent = true})

-- toggle highlight
map.nnore('<leader>th', ':set hlsearch!<CR>')
map.nnore('<leader>n', ':nohl<CR>')
map.nnore('<leader>N', ':Rmhl<CR>')
-- Removes last highlight
command('Rmhl', ':let @/=""')

-- Folds keybinds
map.nnore('<space>', 'za')
map.nnore('<S-Space>', 'zA')

map.tnore('<leader>n', '<C-\\><C-N>')
