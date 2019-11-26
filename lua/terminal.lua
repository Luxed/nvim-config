local list_of_terms = {}

local function Named(name, command)
    -- Add named terminal to list
    if list_of_terms[name] and vim.api.nvim_buf_is_loaded(list_of_terms[name]) then
        -- Open named terminal
        vim.api.nvim_set_current_buf(list_of_terms[name])
    else
        local buf = vim.api.nvim_create_buf(false, false)

        vim.api.nvim_set_current_buf(buf)
        vim.api.nvim_call_function("termopen", {command})

        list_of_terms[name] = buf
    end
end

return {
    Named = Named
}
