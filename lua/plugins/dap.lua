local dap, dapui, dap_virtual_text = require('dap'), require('dapui'), require('nvim-dap-virtual-text')

dapui.setup{}

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

dap_virtual_text.setup()

require('keymaps').dap()

-- TODO: Make sure the debugger only gets attached if it is installed
local mason_path = vim.fn.stdpath('data') .. '/mason'
local netcoredbg_path = mason_path .. '/bin/netcoredbg'
dap.adapters.coreclr = {
  type = 'executable',
  command = netcoredbg_path,
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'launch - netcoredbg',
    request = 'launch',
    program = function()
      -- TODO: Although this works, it would be better if it was completely automatic. Or maybe at least configured per project somehow
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end
  }
}

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiagnosticDefaultError' })
vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DiagnosticDefaultError' })
