local M = {}

-- TODO: This currently only works for single executable projects. You cannot put a breakpoint in a library project that is referenced by the main executable project.
--       I am unsure how to fix this or if it is even possible.
-- TODO: "attach" to a running process
-- TODO: "attach" to a running process in a docker container
M.configure_dap = function(client)
  client = client or require('omnisharp.utils').get_current_omnisharp_client()
    local params = {
      fileName = vim.fn.expand('%:p'),
    }

    client.request('o#/project', params, function(err, result)
      if err then
        vim.notify('There was an error while trying to get the project information', vim.log.levels.ERROR)
        return
      end

      local project = result.MsBuildProject
      if not project.IsExe then
        vim.notify('Only executable projects are currently supported', vim.log.levels.ERROR)
        return
      end

      local dll_path = project.TargetPath
      local launch_name = 'Launch - ' .. project.AssemblyName

      local dap = require('dap')
      if dap.configurations.cs == nil then
        dap.configurations.cs = {}
      end

      local add_config = true
      for _, config in pairs(dap.configurations.cs) do
        if config.name == launch_name then
          add_config = false
        end
      end

      if add_config then
        table.insert(dap.configurations.cs, {
          type = 'coreclr',
          name = launch_name,
          request = 'launch',
          program = dll_path
        })
      end
    end)
end

return M
