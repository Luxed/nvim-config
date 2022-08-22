local utils = require('omnisharp.utils')
local log = require('omnisharp.log')

local M = {}

M.project = function(client, handler)
  client = client or utils.get_current_omnisharp_client()
  local params = utils.make_current_file_params()

  client.request('o#/project', params, function(err, result)
    if err then
      log.error('There was an error while trying to get the project information')
      return
    end

    handler(result.MsBuildProject)
  end)
end

M.projects = function(client, handler)
  client = client or utils.get_current_omnisharp_client()
  local params = utils.make_current_file_params()

  client.request('o#/projects', params, function(err, result)
    if err then
      log.error('There was an error while trying to get the workspace information')
      return
    end

    handler(result.MsBuild)
  end)
end

M.highlight = function(client, handler)
  client = client or utils.get_current_omnisharp_client()
  local params = utils.make_current_file_params()

  client.request('o#/v2/highlight', params, function(err, result)
    if err then
      log.error('There was an error while trying to get highlighting information')
      return
    end

    handler(result.Spans)
  end)
end

M.fix_usings = function(client, handler)
  client = client or utils.get_current_omnisharp_client()
  local params = utils.make_current_file_params()

  client.request('o#/fixusings', params, function(err, result)
    if err then
      log.error('There was an error while trying to fix and sort usings')
      return
    end

    handler(result.Buffer)
  end)
end

return M
