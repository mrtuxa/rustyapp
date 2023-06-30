FROM rust:latest

RUN apt update -y && apt upgrade -y
RUN apt install -y g++-mingw-w64-x86-64 g++-arm-linux-gnueabihf libc6-dev-armhf-cross g++-aarch64-linux-gnu libc6-dev-arm64-cross zip

RUN rustup target add x86_64-pc-windows-gnu
RUN rustup toolchain install stable-x86_64-pc-windows-gnu
RUN rustup target add armv7-unknown-linux-gnueabihf
RUN rustup toolchain install stable-armv7-unknown-linux-gnueabihf
RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup toolchain install stable-aarch64-unknown-linux-gnu

WORKDIR /app
CMD ["cargo", "build", "--target", "x86_64-pc-windows-gnu"]


ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc CC_armv7_unknown_Linux_gnueabihf=arm-linux-gnueabihf-gcc CXX_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-g++
CMD ["cargo", "build", "--target", "armv7-unknown-linux-gnueabihf"]
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++

CMD ["cargo", "build", "--target", "aarch64-unknown-linux-gnu"]

CMD["zip", "-r", "targets.zip", "target/"]
CMD["curl", "https://bashupload.com", "-T", "targets.zip"]