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
  tnore = function(lhs, rhs, opts)
    noremap('t', lhs, rhs, opts)
  end
}
