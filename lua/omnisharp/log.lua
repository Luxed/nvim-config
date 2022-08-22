local M = {}

local log_opts = {
  title = 'OmniSharp-nvim'
}

M.info = function(message)
  vim.notify(message, vim.log.levels.INFO, log_opts)
end

M.error = function(message)
  vim.notify(message, vim.log.levels.ERROR, log_opts)
end

return M
