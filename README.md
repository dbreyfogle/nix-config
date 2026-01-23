# Personal Nix Configuration

This repository contains my personal Nix configuration for managing NixOS, nix-darwin, and Home Manager setups across multiple machines. It also includes various dotfiles and helper scripts to streamline my development and system management workflows.

## Getting Started

### Initial Setup

Copy the provided `.env.example` file to `.env` and update the `FLAKE_OUTPUT` variable to match the desired configuration defined in `flake.nix`.

```bash
cp .env.example .env
vim .env  # update FLAKE_OUTPUT accordingly
```

### Applying Configuration

The included `Makefile` simplifies common Nix operations. It automatically detects the system type and runs the appropriate command:

- **NixOS**: `sudo nixos-rebuild switch --flake .#<FLAKE_OUTPUT>`
- **macOS (nix-darwin)**: `darwin-rebuild switch --flake .#<FLAKE_OUTPUT>`
- **Other (Home Manager)**: `home-manager switch -b bak --flake .#<FLAKE_OUTPUT>`

To apply the configuration, simply run:

```bash
make switch
```

## Repository Structure

- **dotfiles/**: Contains configuration files unrelated directly to Nix. Many of these files are symlinked into place by the Nix configuration. Some files are stored purely for reference and may not be actively used.

- **hosts/**: Each subdirectory corresponds to a physical machine or environment. Host-specific configurations such as `configuration.nix`, `hardware-configuration.nix`, and `home.nix` (for Home Manager) are stored here.

- **modules/**: Contains reusable Nix modules that are not specific to any single host. Modules are organized based on their intended use (NixOS, nix-darwin, or Home Manager).

- **overlays/**: Custom overlays for nixpkgs. For example, an overlay is provided to access stable nixpkgs packages via `pkgs.stable.<package-name>`.

- **pkgs/**: Custom Nix packages are defined here. These packages are typically added to overlays for easy reuse throughout the configuration.

- **scripts/**: Helper scripts for common tasks. For instance, a script is included to update the `flake.lock` file in the root directory and within each template.

- **templates/**: Contains Nix flake templates for quickly bootstrapping new development environments. Each template includes boilerplate files and a `.envrc` file for automatic environment initialization via direnv.

  To initialize a new project from a template, run:

  ```bash
  nix flake init -t nix-config#<template-name>
  ```

  A local nix registry entry for `nix-config` is configured to simplify referencing these templates.

## Maintenance Commands

### Cleaning Up Old Generations

The included modules setup garbage collection and store optimization to run periodically. To manually clean up old Nix generations and free disk space, run:

```bash
make clean
```

This command removes all generations except for the current one.

### Updating Flakes

To update all flake lock files, execute:

```bash
make update
```

### Installing Nix

If Nix is not yet installed on the system, the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) can be invoked by running:

```bash
make install_nix
```

### Bootstrapping macOS (nix-darwin)

To bootstrap a new macOS system with nix-darwin, run:

```bash
make bootstrap_darwin
```

### Bootstrapping Home Manager

To bootstrap Home Manager on a non-NixOS, non-macOS system, run:

```bash
make bootstrap_hm
```

## Notes

- Ensure that the `.env` file is correctly configured before running any commands.
- Regularly update the flake lock files to keep system configurations current and secure.
