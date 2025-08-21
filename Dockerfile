# ---------- Build Stage ----------
FROM rust:slim AS builder

WORKDIR /usr/src/app

# System deps for MySQL/MariaDB
RUN apt update && \
    apt install -y \
        libmariadb-dev-compat \
        libmariadb-dev \
        pkg-config \
        build-essential \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy Cargo files first for caching
COPY Cargo.toml Cargo.lock ./

# Copy full source code
COPY . .

# Build release binary
RUN cargo build --release

# ---------- Runtime Stage ----------
FROM debian:bookworm-slim AS runtime
WORKDIR /usr/src/app

# Copy release binary from builder
COPY --from=builder /usr/src/app/target/release/heliaweb .

# Minimal runtime deps
RUN apt update && \
    apt install -y \
        ca-certificates \
        libmariadb3 && \
    rm -rf /var/lib/apt/lists/*

# Expose port
EXPOSE 8080

# Run the binary
CMD ["./heliaweb"]
