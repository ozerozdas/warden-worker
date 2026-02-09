#!/bin/bash
set -e

# Install Rust if not present
if ! command -v cargo &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal
    source "$HOME/.cargo/env"
fi

# Add wasm target
rustup target add wasm32-unknown-unknown

# Install worker-build if not present
if ! command -v worker-build &> /dev/null; then
    echo "Installing worker-build..."
    cargo install worker-build
fi

# Build the worker
worker-build --release
