local nvim = require("aniseed.nvim")
local list_of_terms = {}
local function create_term(name, command)
  local term = {buffer = nil, command = command, name = name}
  return term
end
local function isloaded_term(term)
  return (term.buffer and nvim.buf_is_loaded(term.buffer))
end
local function switch_term(term)
  if isloaded_term(term) then
    nvim.set_current_buf(term.buffer)
  else
    local buf = nvim.create_buf(false, false)
    nvim.set_current_buf(buf)
    nvim.call_function("termopen", {term.command})
    term["buffer"] = buf
  end
  return nil
end
local function add(name, command)
  if not list_of_terms[name] then
    local term = create_term(name, command)
    list_of_terms[name] = term
  end
  switch_term(list_of_terms[name])
  return nil
end
local function create_command(name, command)
  return ("lua require('terminal').Named('" .. name .. "', '" .. command .. "')")
end
return {CreateCommand = create_command, Named = add}