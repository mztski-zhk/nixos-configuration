# Agent Guide

This repo follows the dendritic pattern and atomic design for NixOS + Home Manager.
The goal is readable, reproducible configurations across NixOS, Arch (standalone Nix),
and Raspberry Pi 5 (standalone Nix), with extensible profile-based composition.

## Core Principles

- Every file is a module, except `flake.nix`.
- Single responsibility per file. Avoid mixing domains.
- Use `import-tree` to auto-load modules.
- Use `flake-parts` with `flake.homeModules` for Home Manager.
- External HM modules (e.g., nvf) must be imported via atomic modules under
  `modules/home/<user>/` and composed through sets/profiles.
- Prefer profiles (molecules) that compose atomic modules.
- Keep OS/platform-specific features isolated behind profiles.

## Topology

- `modules/`
  - `profiles/` (entrypoints)
  - `sets/` (atomic groups for NixOS)
  - `home/` (Home Manager integration and user modules)
  - `hosts/` (machine-specific NixOS configuration)
  - `features/` (desktop, remote, gaming, etc.)
  - `security/` (firewall, sudo, fail2ban, users)
  - `services/`, `audio/`, `nix/`, `fix/`

## Profile Strategy

Use profiles to select what runs on which OS and platform.

### NixOS Sets (atomic groups)

- `sets/core` (nix + hosts + security + home)
- `sets/desktop` (audio + features)
- `sets/services` (system services)

### NixOS Profiles (entrypoints)

- `profiles/nixos`
- `profiles/pi` (only if Pi runs NixOS)

### Home Manager Sets (atomic groups)

- `home/set/base` (cli + develop + terminal)
- `home/set/editors-tui` (neovim)
- `home/set/editors-gui` (vscode + zed)
- `home/set/desktop` (gtk/qt/xdg + browsers)
- `home/set/nixos-packages` (NixOS-only apps)

### Home Manager Profiles (entrypoints)

- `home/profiles/nixos` (desktop host)
- `home/profiles/arch` (standalone)
- `home/profiles/pi` (standalone)

## OS Targeting

- NixOS host uses `flake.nixosConfigurations.<host>` and profile imports.
- Arch Linux and Raspberry Pi (standalone Nix) use `flake.homeConfigurations`.
  - Include only portable modules (CLI/shell/git/ssh/security, vim/neovim).
  - Exclude desktop/theming unless explicitly enabled.

## Home Manager Integration

- Home Manager modules are published as `flake.homeModules.*`.
- Use `inputs.home-manager.flakeModules.home-manager` in `flake.nix`.
- A NixOS HM module should import `inputs.self.homeModules.homeProfileNixos`.

## Adding Modules

- Put atomic modules under `modules/<domain>/<feature>.nix`.
- Add profile aggregators under `modules/profiles/<profile>.nix`.
- Keep OS-specific logic out of atomic modules; place it in profiles.

## Reproducibility

- All inputs are pinned in `flake.lock`.
- Avoid impure fetches.
- Keep `system.stateVersion` and `home.stateVersion` stable.

## Example Composition (Conceptual)

NixOS host:

```
profiles.nixos
```

Arch / Pi (standalone HM):

```
home/profiles/arch
home/profiles/pi
```
