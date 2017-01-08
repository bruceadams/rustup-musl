#!/bin/bash

# We make a point of sharing the cargo download cache directories with the host
# system; this seems to work and avoids redownloading on every run.
# I do not know if it is safe...

docker run --interactive \
           --rm \
           --tty \
           --user "$(id -u):$(id -g)" \
           --volume $HOME/.cargo/git:/home/rust/.cargo/git \
           --volume $HOME/.cargo/registry:/home/rust/.cargo/registry \
           --volume $PWD:$PWD \
           --workdir $PWD \
           bruceadams/rustup-musl:clang \
           "$@"
