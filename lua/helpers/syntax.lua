return {
  getCursorHighlights = function()
    local ft = vim.bo.filetype
    local ts_ft = ft
    if ts_ft == 'cs' then
      ts_ft = 'c_sharp'
    end

    local is_ts_enabled = require('nvim-treesitter.configs').is_enabled('highlight', ts_ft) and require('nvim-treesitter.configs').is_enabled('playground', ts_ft)
    if is_ts_enabled then
      require('nvim-treesitter-playground.hl-info').show_hl_captures() 
    else
      local synstack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
      local map = vim.fn.map(synstack, 'synIDattr(v:val, "name")')
      return vim.fn.join(vim.fn.reverse(map), ' ')
    end
  end
}
