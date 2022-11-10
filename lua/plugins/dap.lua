local dap, dapui, dap_virtual_text = require('dap'), require('dapui'), require('nvim-dap-virtual-text')

dapui.setup{}

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close({})
end

dap_virtual_text.setup({})

require('keymaps').dap()

--[[ local mason_path = vim.fn.stdpath('data') .. '/mason'
local netcoredbg_path = mason_path .. '/bin/netcoredbg'
dap.adapters.coreclr = {
  type = 'executable',
  command = netcoredbg_path,
  args = {'--interpreter=vscode'}
} ]]

dap.configurations.cs = {
  {
    name = "Attach to process",
    type = 'coreclr',
    request = 'attach',
    -- TODO: I _think_ the process could be found automatically using a similar method to the automatic
    processId = require('dap.utils').pick_process,
    args = {}
  }
}

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiagnosticDefaultError' })
vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DiagnosticDefaultError' })
