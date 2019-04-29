function! GetAsciidocSectionNumber(char)
    if a:char == '='
        return 1
    elseif a:char == '-'
        return 2
    elseif a:char == '~'
        return 3
    elseif a:char == '^'
        return 4
    elseif a:char == '+'
        return 5
    else
        " This should never happen
        return -99
    endif
endfunction

function! GetAsciidocFold()
    let currentl = getline(v:lnum)
    let nextl = getline(v:lnum + 1)
    let fullline_header = '^\(=\|-\|~\|\^\|+\)\+$'
    let sameline_header = '^=\+'

    if nextl =~ fullline_header
        return '>' . GetAsciidocSectionNumber(strpart(nextl, 1, 1))
    elseif currentl =~ sameline_header && currentl !~ fullline_header
        return '>' . len(matchstr(currentl, '^=\+'))
    else
        return '='
    endif

    return '0'
endfunction

set foldmethod=expr
set foldexpr=GetAsciidocFold()
