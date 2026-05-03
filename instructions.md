# NixOS Configuration Style Guide for AI Systems

## Overview

This document provides comprehensive guidelines for AI systems to architect, refactor, and manage NixOS configurations following the dendritic pattern and best practices. The primary goal is to ensure high readability, strict reproducibility across different machines, and a highly modular, maintainable codebase.

## Core Principles

### 1. Declarative Paradigm
- Use Nix declarative syntax for almost everything
- Avoid imperative scripts where a declarative Nix alternative exists
- All configurations should be idempotent and reproducible

### 2. Dotfile Management
- Manage program dotfiles only within the Nix configurations
- Use Home Manager integrations or standard NixOS environment overlays
- Do not rely on external dotfile symlink managers

### 3. Reproducibility
- Every configuration must be capable of building identical systems on different machines
- Use deterministic package versions where possible
- Avoid non-deterministic build processes

### 4. Strict Constraints
- **DO NOT** attempt to read, write, or edit directories outside of `/etc/nixos`
- **DO NOT** sacrifice reproducibility
- **DO NOT** create monolithic `configuration.nix` files
- **DO NOT** mix concerns in single modules

## Architectural Patterns

### Dendritic Pattern

The dendritic pattern is the foundational architecture for this configuration system.

#### Core Principles

1. **Every file is a module** - All Nix files (except `flake.nix`) are flake-parts modules
2. **Single feature per file** - Each module implements one feature across all configurations
3. **Path-based naming** - File paths serve to name features
4. **Automatic importing** - Uses `import-tree` to auto-import all modules
5. **File path independence** - Files can be freely renamed/moved
6. **Top-level configuration** - Uses flake-parts for evaluation
7. **No specialArgs pass-thru** - Values shared through top-level config
8. **Named modules as needed** - Only when imported in some configs but not others
9. **Underscore prefix** - Files starting with `_` are ignored by import-tree

#### Module Structure

```nix
# modules/feature-name.nix
{ self, inputs, ... }: {
  flake.modules = {
    nixos.base = {
      # Configuration for base profile
    };
    homeManager.base = { pkgs, ... }: {
      # Configuration for home manager base profile
    };
  };
}
```

#### Directory Structure

```
/etc/nixos/
├── flake.nix                    # Entry point
├── modules/                     # All top-level modules
│   ├── audio/                   # Feature: audio
│   │   ├── pipewire.nix        # Single feature: pipewire
│   │   └── ...
│   ├── hardware/                # Feature: hardware
│   │   ├── nvidia.nix          # Single feature: nvidia
│   │   └── asus.nix            # Single feature: asus
│   ├── binary-cache/           # Feature: binary cache
│   │   └── default.nix         # Combined cache configuration
│   ├── networking.nix          # Single feature: networking
│   ├── nix.nix                  # Single feature: nix settings
│   └── ...
└── users/                       # User configurations
    └── username/
        ├── modules/             # User modules
        └── home.nix             # User configuration
```

### Suites and Profiles Pattern

Organize configurations by defining atomic "profiles" and grouping them into "suites".

#### Profiles (Atomic Units)
Single-purpose configurations that set system state within specific domains.

**Profile Categories:**
- `profiles/core/` - base, networking, security, shell, nix settings
- `profiles/desktop/` - audio, fonts, display, theming
- `profiles/hardware/` - nvidia, asus, graphics, power management
- `profiles/development/` - containers, tools, development packages
- `profiles/services/` - nginx, ssh, vpn, security-services

#### Suites (Molecular Units)
Composable mechanisms for profile aggregation.

**Example Suites:**
- `suites/workstation.nix` - desktop + development + gaming
- `suites/server.nix` - core + networking + services

### Atomic and Molecular Pattern

Build configurations from the bottom up:

1. **Atoms** - Small, single-purpose configuration files
2. **Molecules** - Functional groups formed by combining atoms
3. **Full System** - Complete system built from molecules

## Tooling Requirements

### Required Tools

#### flake-parts
- **Purpose**: Organize the flake output schema efficiently
- **Usage**: Module organization and flake structure
- **Implementation**: Used in `flake.nix` for system configuration

#### import-tree
- **Purpose**: Handle directory-based module loading without maintaining massive import arrays
- **Usage**: Automatic module discovery and loading
- **Implementation**: Used in `flake.nix` for both system and user modules

#### wrapper-modules
- **Purpose**: Wrap and standardize third-party or complex Nix modules
- **Usage**: Standardizing external module interfaces
- **Implementation**: Used for complex third-party integrations

### Flake Configuration

```nix
{
  description = "Modular NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    # ... other inputs
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake
      { inherit inputs; }
      ({
        systems = [ "x86_64-linux" ];
        imports = [
          (inputs.import-tree ./modules)
        ];
        # ... flake outputs
      });
}
```

## Module Development Guidelines

### Module Creation Rules

1. **Single Responsibility**: Each module handles one specific feature
2. **Path-based Naming**: File paths clearly indicate their purpose
3. **No Circular Dependencies**: Clean dependency structure
4. **Proper Module Pattern**: Use `flake.modules` for module definitions

### Module Template

```nix
# modules/feature-name.nix
{ self, inputs, ... }: {
  flake.modules = {
    nixos.base = {
      # NixOS configuration
    };
    homeManager.base = { pkgs, ... }: {
      # Home Manager configuration
    };
  };
}
```

### Named Modules

For configurations that are only needed in some hosts:

```nix
# modules/configurations/specific-host.nix
{ config, ... }: {
  flake.nixosConfigurations.specificHost = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # ... configuration
    ];
  };
}
```

## Configuration Organization

### System Configuration Structure

```
modules/
├── audio/                   # Audio configuration
│   └── pipewire.nix
├── binary-cache/           # Binary cache setup
│   └── default.nix
├── desktop/                 # Desktop environment
│   ├── fonts.nix
│   ├── shell.nix
│   └── display-manager.nix
├── development/             # Development tools
│   ├── containers.nix
│   └── tools.nix
├── hardware/                # Hardware configuration
│   ├── nvidia.nix
│   └── asus.nix
├── security/                # Security settings
│   ├── firewall.nix
│   ├── users.nix
│   └── impermanence.nix
├── services/                # System services
│   ├── nginx.nix
│   ├── ssh.nix
│   ├── vpn.nix
│   └── remote-control.nix
├── configurations/          # Host configurations
│   └── nixos.nix
├── boot.nix                 # Boot configuration
├── networking.nix          # Network configuration
└── nix.nix                  # Nix settings
```

### User Configuration Structure

```
users/username/
├── modules/                 # User modules
│   ├── waybar.nix           # Main waybar config
│   ├── waybar/
│   │   ├── settings.nix     # Waybar settings
│   │   └── modules/        # Waybar atomic modules
│   │       ├── workspaces.nix
│   │       ├── window.nix
│   │       ├── clock.nix
│   │       └── ...
│   └── ...
└── home.nix                 # User configuration entry point
```

## Best Practices

### Code Style

1. **Consistency**: Uniform module structure across all files
2. **Documentation**: Clear file naming indicates purpose
3. **Error Handling**: Proper use of `lib.mkForce` where needed
4. **Type Safety**: Proper use of NixOS module system

### Module Composition

```nix
# Good: Atomic module
{ self, inputs, ... }: {
  flake.modules.homeManager.waybar = {
    programs.waybar.enable = true;
  };
}

# Good: Specific feature module
{ self, inputs, ... }: {
  flake.modules.homeManager.waybar = {
    programs.waybar.settings.mainBar.clock = {
      format = "{:%H:%M}";
    };
  };
}
```

### Import Management

- Use `import-tree` for automatic module discovery
- Avoid manual import arrays where possible
- Use path-based naming for module organization

### Configuration Merging

- Use proper NixOS module merging
- Avoid conflicts with `lib.mkForce` when necessary
- Understand priority and override mechanisms

## Binary Cache Configuration

### Cache Strategy

Use multiple binary caches to reduce compilation time and improve build speed:

```nix
{ self, inputs, ... }: {
  flake.nixosModules.binaryCache = {
    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3Wxa7aRdj6jgF4TWDqxKEyE44r2jQ5PrpHFgQWlDwq0="
        "devenv.cachix.org-1:w1cLUiFdvx2qL44Q6DB6q1go+D7Jr4bIqBqDQD/9nqg="
      ];
    };
  };
}
```

### Cache Selection Criteria

- **Official**: `cache.nixos.org` - Always include
- **Community**: `nix-community.cachix.org` - High priority
- **Specialized**: Add based on specific needs (wayland, development, etc.)

## Theming and Styling

### Catppuccin Integration

Use the Catppuccin module for consistent theming:

```nix
# Add to flake inputs
catppuccin.url = "github:catppuccin/nix";

# Add to home-manager imports
inputs.catppuccin.homeModules.catppuccin

# Configure in user module
catppuccin = {
  enable = true;
  flavor = "macchiato";
  accent = "blue";
};
```

### Waybar Configuration

Follow Niri-specific Waybar configuration:

```nix
programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];
      # ... other modules
    };
  };
};
```

## Error Resolution Guidelines

### Common Issues and Solutions

#### Infinite Recursion
**Problem**: Using `config` in `imports` creates circular dependencies
**Solution**: Never use `config` in imports, use direct module references

#### Binary Cache Issues
**Problem**: Packages building from source instead of using cache
**Solution**: Add appropriate binary caches and verify trusted-public-keys

#### Module Not Found
**Problem**: Module not tracked by Git
**Solution**: Always add new files to Git before building

#### Option Conflicts
**Problem**: Multiple definitions of the same option
**Solution**: Use `lib.mkForce` or `lib.mkDefault` to resolve conflicts

### Web Search Guidelines

When encountering errors:
1. Use web search to find recent solutions
2. Check NixOS Discourse and GitHub issues
3. Verify NixOS version compatibility
4. Test solutions in isolated environment first

## Workflow Requirements

### Development Process

1. **Search First**: Explore existing configuration tree before proposing changes
2. **Plan (Spec-Driven)**: Outline clear plan before writing code
3. **Execute**: Implement using Nix modules with proper modularity
4. **Self-Check**: Review changes against guidelines before completion

### Quality Assurance

1. **Build Testing**: Always test configuration builds successfully
2. **Functional Verification**: Ensure exact same functionality as original
3. **Style Compliance**: Follow dendritic pattern strictly
4. **Documentation**: Maintain clear file naming and structure

### Error Resolution Protocol

1. **Web Search**: Use web search for error solutions
2. **Iteration**: Check imports and configuration correctness
3. **Verification**: Ensure configuration matches original exactly
4. **Quality Evaluation**: Assess configuration skills and compliance

## Advanced Patterns

### Specialization Handling

Use NixOS specializations for different system states:

```nix
specialisation = {
  gaming-time.configuration = {
    # Gaming-specific configuration
  };
};
```

### Impermanence Integration

Properly configure system impermanence:

```nix
environment.persistence."/persist" = {
  hideMounts = true;
  directories = [
    "/etc/nixos"
    "/var/log"
    # ... other directories
  ];
};
```

### Container Configuration

Use proper container configuration with Podman:

```nix
virtualisation = {
  containers.enable = true;
  oci-containers.backend = "podman";
  podman = {
    enable = true;
    dockerCompat = true;
  };
};
```

## Security Considerations

### User Management

```nix
users.mutableUsers = false;
users.users.username = {
  isNormalUser = true;
  extraGroups = ["wheel" "networkmanager"];
  hashedPassword = "hashed_password_here";
  openssh.authorizedKeys.keys = [
    "ssh-public-key-here"
  ];
};
```

### Firewall Configuration

```nix
networking.firewall = {
  enable = true;
  trustedInterfaces = ["tailscale0"];
};
```

### Service Security

```nix
services.fail2ban = {
  enable = true;
  maxretry = 5;
  # ... other configuration
};
```

## Performance Optimization

### Build Optimization

1. **Binary Caches**: Use multiple caches for faster builds
2. **Parallel Builds**: Enable parallel compilation where possible
3. **Cache Management**: Regular garbage collection of old builds

### System Performance

1. **GPU Configuration**: Proper NVIDIA/AMD GPU setup
2. **Power Management**: ASUS laptop power optimization
3. **Resource Limits**: Appropriate system resource limits

## Troubleshooting Guide

### Common Build Issues

#### Module Import Errors
- Check Git tracking status
- Verify file paths and naming
- Ensure proper flake.modules pattern

#### Configuration Conflicts
- Use `lib.mkForce` for priority
- Check for duplicate definitions
- Verify module merging behavior

#### Binary Cache Problems
- Verify substituter URLs
- Check trusted-public-keys
- Test cache availability

### Debugging Techniques

1. **Build Testing**: Use `nixos-rebuild build --show-trace`
2. **Configuration Evaluation**: Use `nix eval` to check values
3. **Module Inspection**: Use `nix flake show` to examine structure

## Maintenance Guidelines

### Regular Updates

1. **Flake Updates**: Regular `nix flake update`
2. **System Rebuilds**: Periodic `nixos-rebuild switch`
3. **Garbage Collection**: Regular `nix-collect-garbage`

### Documentation Maintenance

1. **File Naming**: Keep clear, descriptive names
2. **Module Organization**: Maintain logical structure
3. **Comments**: Add inline documentation for complex configurations

### Version Management

1. **State Version**: Never change `home.stateVersion` or `system.stateVersion` without reason
2. **Channel Alignment**: Keep NixOS and Home Manager versions aligned
3. **Dependency Updates**: Update inputs regularly for security patches

## Compliance Checklist

### Before Submitting Configuration

- [ ] All files follow dendritic pattern
- [ ] No circular dependencies
- [ ] Proper use of flake.modules
- [ ] Files tracked by Git
- [ ] Configuration builds successfully
- [ ] Binary caches properly configured
- [ ] No monolithic files
- [ ] Single feature per file
- [ ] Path-based naming followed
- [ ] Proper error handling
- [ ] Security best practices followed

### Code Quality Standards

- [ ] Consistent code style
- [ ] Clear file naming
- [ ] Proper module structure
- [ ] No hardcoded values where avoidable
- [ ] Proper use of NixOS options
- [ ] Type safety maintained
- [ ] Documentation where needed

## Conclusion

This style guide provides the foundation for creating maintainable, reproducible, and scalable NixOS configurations. By following these guidelines, AI systems can effectively manage complex NixOS configurations while ensuring consistency and quality across different environments.

The dendritic pattern, combined with proper tooling and architectural principles, creates a robust foundation for NixOS configuration management that scales from simple setups to complex multi-machine deployments.

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Dendritic Pattern](https://github.com/mightyiam/dendritic)
- [Flake Parts](https://flake.parts/)
- [Import Tree](https://github.com/vic/import-tree)
- [Catppuccin](https://github.com/catppuccin/nix)
- [Binary Cache Guide](https://nixos.wiki/wiki/Binary_Cache)

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-28  
**Maintained By**: NixOS Configuration Architect System