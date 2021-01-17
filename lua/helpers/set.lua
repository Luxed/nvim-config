-- only needed until "https://github.com/neovim/neovim/pull/13479" is merged
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local setAssign = function(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

local setIncrement = function(scope, key, value)
  if type(value) ~= 'string' then
    error('Only string values are supported')
  end
  scopes[scope][key] = scopes[scope][key] .. value
end

return function(mode, options)
  for scope, keys in pairs(options) do
    for k, v in pairs(keys) do
      if mode == 'assign' then
        setAssign(scope, k, v)
      elseif mode == 'increment' then
        setIncrement(scope, k, v)
      end
    end
  end
end
