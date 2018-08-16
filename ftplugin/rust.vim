" Custom commands
command! Build :below 10sp term://cd %:p:h && cargo build
command! Run   :below 10sp term://cd %:p:h && cargo run
command! Test  :below 10sp term://cd %:p:h && cargo test

command! Cbadc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build
command! Cradc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run
command! Cbr :tabedit term://cargo run --release

" Bindings
noremap <F4> :Build<CR>
noremap <F5> :Run<CR>
noremap <F6> :Test<CR>
