# rustup-musl

I didn't find other Rust/musl Docker image setups that I was happy with.
This is as simple as I was able to get working.
The hard part was being able to use the `rustls` crate.
The underlying problem came from the `ring` crate, which bundles c and c++ code.

The `rmusl.sh` script included in this repo _just works_ on macOS,
which is really nice. I expect it to work on a Linux host as well.
It successfully caches crate downloads by sharing the cargo cache directories
between the Docker container and the host system.

By default, `rmusl.sh` will run
`cargo build --release --target x86_64-unknown-linux-musl`
in the context of the current working directory.
The output of the build will appear in
`target/x86_64-unknown-linux-musl/release/`
