vim.cmd('packadd nvim-autopairs')
local npairs = require('nvim-autopairs')

npairs.setup{}

_G.MUtils = {}

vim.g.completion_confirm_key = ''

MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"]()
      return npairs.esc("")
    else
      vim.api.nvim_select_popupmenu_item(0, false, false, {})
      vim.fn["compe#confirm"]()
      return npairs.esc("<c-n>")
    end
  else
    return npairs.check_break_line_char()
  end
end
