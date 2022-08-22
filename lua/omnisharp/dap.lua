local log = require('omnisharp.log')
local request = require('omnisharp.request')

local function make_dap_configuration(project)
  return {
    type = 'coreclr',
    name = 'Launch - ' .. project.AssemblyName,
    request = 'launch',
    program = project.TargetPath
  }
end

local M = {}

-- TODO: This currently only works for single executable projects. You cannot put a breakpoint in a library project that is referenced by the main executable project.
--       I am unsure how to fix this or if it is even possible.
-- TODO: "attach" to a running process
-- TODO: "attach" to a running process in a docker container
M.configure_dap = function(client)
  request.project(client, function(project)
    if not project.IsExe then
      -- vim.notify('Only executable projects are currently supported', vim.log.levels.ERROR)
      return
    end

    local dap = require('dap')
    if dap.configurations.cs == nil then
      dap.configurations.cs = {}
    end

    local dap_config = make_dap_configuration(project)

    local add_config = true
    for _, config in pairs(dap.configurations.cs) do
      if config.name == dap_config.name then
        add_config = false
      end
    end

    if add_config then
      table.insert(dap.configurations.cs, dap_config)
    end
  end)
end

M.launch_current_configuration = function()
  request.project(nil, function(project)
    if not project.IsExe then
      log.error('Only executable projects are currently supported')
      return
    end

    local dap_config = make_dap_configuration(project)
    require('dap').run(dap_config)
  end)
end

return M
