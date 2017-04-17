FROM ubuntu

RUN apt-get update && \
    apt-get install -y build-essential curl file make musl-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --create-home rust
USER rust
WORKDIR /home/rust
# Set up our path to include our Rust toolchain
ENV HOME=/home/rust
ENV PATH=$HOME/.cargo/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
RUN rustup target add x86_64-unknown-linux-musl

# The container will be run with an arbitrary UID.
# Make sure our space is writable by any UID.
RUN chmod -R a+w $HOME

# Our default command is a release build targetting 64bit musl
CMD ["/home/rust/.cargo/bin/cargo", \
     "build", \
     "--release", \
     "--target", \
     "x86_64-unknown-linux-musl"]
