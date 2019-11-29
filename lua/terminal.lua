local list_of_terms = {}
local function create_term(name, command)
  local term = {buffer = nil, command = command, name = name}
  return term
end
local function isloaded_term(term)
  return (term.buffer and vim.api.nvim_buf_is_loaded(term.buffer))
end
local function switch_term(term)
  if isloaded_term(term) then
    vim.api.nvim_set_current_buf(term.buffer)
  else
    local buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_call_function("termopen", {term.command})
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
return {Named = add}

-- Older version
--[[local list_of_terms = {}

local Terminal = {}
Terminal.__index = Terminal

function Terminal.create(name, command)
    local term = setmetatable({}, Terminal)

    term.name = name
    term.command = command
    term.buffer = nil

    return term
end

function Terminal:is_loaded()
    return self.buffer and vim.api.nvim_buf_is_loaded(self.buffer)
end

function Terminal:switch_to_buffer()
    if self:is_loaded() then
        vim.api.nvim_set_current_buf(self.buffer)
    else
        local buf = vim.api.nvim_create_buf(false, false)

        vim.api.nvim_set_current_buf(buf)
        vim.api.nvim_call_function("termopen", {self.command})

        self.buffer = buf
    end
end

local function Named(name, command)
    if not list_of_terms[name] then
        local term = Terminal.create(name, command)

        list_of_terms[name] = term
    end

    list_of_terms[name]:switch_to_buffer()
end

return {
    Named = Named
}]]
