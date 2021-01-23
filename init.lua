if string.find(vim.o.shell, 'fish') ~= nil then
  if vim.fn.filereadable('/bin/zsh') == 1 then
    vim.o.shell = '/bin/zsh'
  elseif vim.fn.filereadable('/bin/bash') == 1 then
    vim.o.shell = '/bin/bash'
  end
end

require('00_vanilla')
require('01_plugins')

-- load colorscheme as soon as possible
vim.cmd('colorscheme ayu')

require('02_plugins_conf')

local config_path = vim.fn.stdpath('config')
if vim.fn.filereadable(config_path .. '/lua/system_config.lua') == 1 then
  require('system_config')
end

vim.cmd('filetype plugin indent on')
