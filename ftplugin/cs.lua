--[[ vim.wo.foldmethod = 'expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'
vim.wo.foldlevel=2 ]]

vim.api.nvim_buf_create_user_command(0, 'DotnetDebug', function()
  require('omnisharp').launch_debug()
end, {})
