-- TODO: find if there's a better way to do this using vim functions
local function hi(group, options)
  local cmd = 'hi! ' .. group .. ' '

  for k,v in pairs(options) do
    cmd = cmd .. k .. '=' .. v .. ' '
  end

  vim.cmd(cmd)
end

local function hi_link(group, link_group)
  vim.cmd('hi! link ' .. group .. ' ' .. link_group)
end


return {
  hi = hi,
  hi_link = hi_link
}
