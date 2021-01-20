-- TODO: refactor this mini-api. There might be a better way to do it (boilerplate is fine, code should never change once it's done)
local function map(mode, lhs, rhs, opts, buffer)
  if buffer then
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local function noremap(mode, lhs, rhs, opts, buffer)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  map(mode, lhs, rhs, options, buffer)
end

return {
  nore = noremap,
  nnore = function(lhs, rhs, opts, buffer)
    noremap('n', lhs, rhs, opts, buffer)
  end,
  inore = function(lhs, rhs, opts, buffer)
    noremap('i', lhs, rhs, opts, buffer)
  end,
  tnore = function(lhs, rhs, opts, buffer)
    noremap('t', lhs, rhs, opts, buffer)
  end,
  xnore = function(lhs, rhs, opts, buffer)
    noremap('x', lhs, rhs, opts, buffer)
  end,
  multi = function(modes, lhs, rhs, opts)
    for _, mode in pairs(modes) do
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end
}
