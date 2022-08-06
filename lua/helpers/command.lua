return {
  command = function(name, cmd)
    vim.cmd(string.format('command! %s %s', name, cmd))
  end,
  buf_command = function(name, cmd)
    vim.cmd(string.format('command! -buffer %s %s', name, cmd))
  end,
}
