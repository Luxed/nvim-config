" HTML usually has a lot of indentations levels, this makes it more readable
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Angular commands
command! -buffer OpenTs :edit %:p:r.ts
command! -buffer OpenCss :edit %:p:r.css
command! -buffer OpenSpec :edit %:p:r.spec.ts
command! -buffer Ots :OpenTs
command! -buffer Ocss :OpenCss
command! -buffer Ospec :OpenSpec
