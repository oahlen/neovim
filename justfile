set positional-arguments

# Show available commands
help:
    @just --list --unsorted

# Update sources to the latest version
@update:
    nvfetcher -o sources
    jq '.' sources/generated.json > sources/generated.json.tmp
    mv sources/generated.json.tmp sources/generated.json

# Build the Neovim configuration
@build:
    nix-build .

# Build and run the Neovim configuration
@run: build
    ./result/bin/nvim

# Install the the Neovim configuration to the default location
@install:
    ln -sfnT "$PWD/config" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# Perform linting and formattig tasks
@lint:
    treefmt
    statix check
    stylua .
