function! wrap#func()
    let wrap_func = input("Function name:")
    call wrap#func_with(wrap_func)
endfunction

function! wrap#func_with(func_name)
    let col_start = getpos("'<")[2]
    let col_end = getpos("'>")[2]
    let current_line = getline(".")
    let before = strpart(current_line, 0, col_start - 1)
    let selected = strpart(current_line, col_start - 1, col_end - col_start + 1)
    let after = strpart(current_line, col_end)

    if a:func_name !=# ""
        call setline(".", before . a:func_name . "(" . selected . ")" . after)
    endif
endfunction
