vim.cmd('packadd nvim-autopairs')
local npairs = require('nvim-autopairs')

npairs.setup{}

_G.MUtils = {}

vim.g.completion_confirm_key = ''

MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end
