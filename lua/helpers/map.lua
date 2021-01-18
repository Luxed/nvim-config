local function noremap(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return {
  nore = noremap,
  nnore = function(lhs, rhs, opts)
    noremap('n', lhs, rhs, opts)
  end,
  inore = function(lhs, rhs, opts)
    noremap('i', lhs, rhs, opts)
  end,
  tnore = function(lhs, rhs, opts)
    noremap('t', lhs, rhs, opts)
  end,
  xnore = function(lhs, rhs, opts)
    noremap('x', lhs, rhs, opts)
  end,
  multi = function(modes, lhs, rhs, opts)
    for _, mode in pairs(modes) do
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end
}
