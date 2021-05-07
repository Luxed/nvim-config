return {
  hi = function(group, options)
    local cmd = 'hi! ' .. group .. ' '

    for k,v in pairs(options) do
      cmd = cmd .. k .. '=' .. v .. ' '
    end

    vim.cmd(cmd)
  end,
  hi_link = function(group, link_group)
    vim.cmd('hi! link ' .. group .. ' ' .. link_group)
  end,
  -- See `:h synIDattr()` for more info
  get_hi_attr = function(hi_name, attr)
    local hl_id = vim.fn.hlID(hi_name)
    local hl_hex_color = vim.fn.synIDattr(hl_id, attr)

    return hl_hex_color
  end
}
