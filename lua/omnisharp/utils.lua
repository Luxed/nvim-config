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
    vim.notify('Could not find a valid OmniSharp client attached to this buffer', vim.log.levels.ERROR)
    return nil
  end
end

return M
