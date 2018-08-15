" Custom commands
command! Cb !cargo build
command! Cbadc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build
command! Cr !cargo run
command! Cradc !RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run
command! Ct !cargo test
command! Cbr :tabedit term://cargo run --release

" Bindings
noremap <F4> :Cb<CR>
noremap <F5> :Cr<CR>
noremap <F6> :Ct<CR>
