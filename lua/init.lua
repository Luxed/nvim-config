local nvim = require("aniseed.nvim")
local terminal = require("terminal")
nvim.ex.command_("-nargs=1", "GTagsContains", "Git tag --contains <q-args>")
nvim.ex.command_("-nargs=1", "GBranchContains", "Git branch --contains <q-args>")
local function term_shell()
  if nvim.fn.has("windows") then
    return "cmd"
  else
    return "zsh"
  end
end
nvim.ex.command_("Terminal", terminal.CreateCommand("shell", term_shell()))
return nil