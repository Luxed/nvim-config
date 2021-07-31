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

local actions = {}
local actions_counter = 0

local function lua_map(mode, keybind, callback, opts)
  actions_counter = actions_counter + 1
  local key = actions_counter
  actions[key] = callback

  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  -- make sure that "buffer" is a boolean
  local buffer = options.buffer and true or false
  if options.buffer then
    options['buffer'] = nil
  end

  map(mode, keybind, ':lua require("helpers.map").__action('.. key ..')<CR>', options, buffer)
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
  end,

  buf = {
    lua = function(mode, keybind, callback, opts)
      opts = vim.tbl_extend('force', opts or {}, { buffer = true })
      lua_map(mode, keybind, callback, opts)
    end
  },

  lua = lua_map,
  __action = function(key)
    actions[key]()
  end
}
