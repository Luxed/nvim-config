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
vim.opt.completeopt = 'menu,menuone,noselect'

vim.opt.shortmess:append('c')
vim.opt.diffopt:append('algorithm:patience')

require('keymaps').vanilla()

local command = require('helpers.command').command

-- Removes last highlight
command('Rmhl', ':let @/=""')
command('DeleteHiddenBuffers', 'call buffers#delete_all_hidden()')

local yank_augroup = vim.api.nvim_create_augroup('yank_post_highlight', {clear = true})
vim.api.nvim_create_autocmd({'TextYankPost'}, {
  group = yank_augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({timeout = 500})
  end
})
