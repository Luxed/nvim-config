local log = require('omnisharp.log')
local M = {}

-- NOTE: this only works if your lsp client is called "omnisharp"
M.get_current_omnisharp_client = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({
    bufnr = bufnr,
    name = 'omnisharp'
  })

  if #clients == 1 then
    return clients[1]
  else
    log.error('Could not find a valid OmniSharp client attached to this buffer')
    return nil
  end
end

M.make_current_file_params = function()
  return {
    fileName = vim.fn.expand('%:p')
  }
end

return M
