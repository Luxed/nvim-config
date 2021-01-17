-- TODO: waiting for https://github.com/neovim/neovim/pull/11613 and https://github.com/neovim/neovim/pull/12378 to be merged
return {
  command = function(name, cmd)
    vim.cmd(string.format('command! %s %s', name, cmd))
  end,
  autocmd = function(event, file, cmd)
    vim.cmd(string.format('autocmd %s %s %s', event, file, cmd))
  end
}
