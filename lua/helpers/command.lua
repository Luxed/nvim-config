-- TODO: waiting for https://github.com/neovim/neovim/pull/11613 and https://github.com/neovim/neovim/pull/12378 to be merged
return {
  command = function(name, cmd)
    vim.cmd(string.format('command! %s %s', name, cmd))
  end,
  autocmd = function(event, file, cmd)
    vim.cmd(string.format('autocmd %s %s %s', event, file, cmd))
  end,
  augroup = function(group_name, autocmds)
    local str_autocmds = ''
    for _, v in ipairs(autocmds) do
      str_autocmds = str_autocmds .. string.format('autocmd %s %s %s', v[1], v[2], v[3]) .. '\n'
    end

    vim.api.nvim_exec(string.format([[
        augroup %s
          autocmd!
          %s
        augroup END
      ]], group_name, str_autocmds), false)
  end
}
