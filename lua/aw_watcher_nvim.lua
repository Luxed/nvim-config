local connected = false
local http_response_code = {}

local function HTTPPostOnExit(jobid, exitcode, eventtype)
  local status_code = tonumber(http_response_code[jobid][1])

  if status_code == 0 then
    vim.notify('aw-watcher-nvim: Failed to connect to aw-server, logging will be disabled. You can retry to connect with :AWStart', vim.log.levels.ERROR)
    connected = false
  elseif status_code >= 100 and status_code < 300 or status_code == 304 then
    connected = true
  else
    vim.notify(string.format('aw-watcher-nvim: aw-server did not accept our request with status code %d. See aw-server logs for reason or stop aw-watcher-vim with :AWStop', status_code), vim.log.levels.ERROR)
  end

  http_response_code[jobid] = nil
end

local function HTTPPostOnStdout(jobid, data, event)
  if data[1] ~= '' then
    http_response_code[jobid] = data
  end
end

local function HTTPPostJson(opts, url, data)
  local command = {
    'curl', '-s', url,
    '-H', 'Content-Type: application/json',
    '-X', 'POST',
    '-d', vim.fn.json_encode(data),
    '-o', '/dev/null',
    '-m', opts.timeout,
    '-w', "%{http_code}"
  }

  vim.fn.jobstart(command, {
    detach = true,
    on_stdout = HTTPPostOnStdout,
    on_exit = HTTPPostOnExit,
  })
end

local function make_bucket_name(opts)
  return string.format('aw-watcher-nvim_%s', opts.hostname)
end

local function make_base_apiurl(opts)
  return string.format('http://%s:%s/api/0', opts.host, opts.port)
end

local function make_bucket_apiurl(opts)
  return string.format('%s/buckets/%s', make_base_apiurl(opts), make_bucket_name(opts))
end

local function make_heartbeat_apiurl(opts)
  return string.format('%s/heartbeat?pulsetime=30', make_bucket_apiurl(opts))
end

local function CreateBucket(opts)
  local body = {
    name = make_bucket_name(opts),
    hostname = opts.hostname,
    client = 'aw-watcher-nvim',
    type = 'app.editor.activity',
  }

  HTTPPostJson(opts, make_bucket_apiurl(opts), body)
end

local last_file = ''
local last_heartbeat = vim.fn.localtime()
local function Heartbeat(opts)
  if not connected then
    return
  end

  local localtime = vim.fn.localtime()
  local timestamp = vim.fn.strftime('%FT%H:%M:%S%z')
  local file = vim.fn.expand('%p')
  local language = vim.bo.filetype
  -- TODO: Current project could also be determined using the current LSP project path
  local project = vim.fn.getcwd()

  if file ~= last_file or (localtime - last_heartbeat) > 1 then
    local body = {
      duration = 0,
      timestamp = timestamp,
      data = {
        file = file,
        language = language,
        project = project,
      }
    }

    HTTPPostJson(opts, make_heartbeat_apiurl(opts), body)
    last_file = file
    last_heartbeat = localtime
  end
end

local function AWStart(opts)
  CreateBucket(opts)
end

local function AWStop()
  connected = false
end

local function AWStatus()
  vim.notify(string.format('aw-watcher-nvim running: %s', connected))
end

local function create_autocommands(opts)
  local aw_group = vim.api.nvim_create_augroup('ActivityWatch', {clear = true})
  vim.api.nvim_create_autocmd({'VimEnter'}, {
    group = aw_group,
    pattern = '*',
    callback = function() AWStart(opts) end
  })
  vim.api.nvim_create_autocmd({'BufEnter', 'CursorMoved', 'CursorMovedI'}, {
    group = aw_group,
    pattern = '*',
    callback = function() Heartbeat(opts) end
  })
  vim.api.nvim_create_autocmd({'CmdlineEnter', 'CmdlineChanged'}, {
    group = aw_group,
    pattern = '*',
    callback = function() Heartbeat(opts) end
  })
end

local function create_user_commands(opts)
  vim.api.nvim_create_user_command('AWHeartbeat', function() Heartbeat(opts) end, {})
  vim.api.nvim_create_user_command('AWStart', function() AWStart(opts) end, {})
  vim.api.nvim_create_user_command('AWStop', function() AWStop() end, {})
  vim.api.nvim_create_user_command('AWStatus', function() AWStatus() end, {})
end

local function default_opts()
  return {
    create_autocommands = true,
    create_user_commands = true,

    host = '127.0.0.1',
    port = '5600',
    timeout = 2,
    hostname = vim.fn.hostname(),
  }
end

return {
  start = AWStart,
  stop = AWStop,
  status = AWStatus,
  setup = function(opts)
    opts = vim.tbl_deep_extend("force", default_opts(), opts or {})

    if opts.create_autocommands then
      create_autocommands(opts)
    end

    if opts.create_user_commands then
      create_user_commands(opts)
    end
  end,
}
