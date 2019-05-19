" Custom commands
command! -buffer Build :below 10sp term://cd %:p:h && cargo build
command! -buffer Run   :tabedit term://cd %:p:h && cargo run
command! -buffer Test  :below 10sp term://cd %:p:h && cargo test
command! -buffer Cbr   :below 10sp term://cd %:p:h && cargo run --release

command! -buffer Cbadc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build
command! -buffer Cradc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run
" Bindings
noremap <buffer> <F4> :Build<CR>
noremap <buffer> <F5> :Run<CR>
noremap <buffer> <F6> :Test<CR>
