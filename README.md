# My nix configuration

## Intro

This is my nixos configuration with my daily & server use.

## My device

- Asus Laptop
  Is the main device of this config.

  Use it with:

  ````bash
  sudo nixos-rebuild switch .#nixos
  ````

- Raspberry Pi 5
  
  > Haven't configured yet.
  
  Use it with:

  ````bash
  sudo nixos-rebuild switch .#resp
  ````

- Arch Laptop
  
  > Haven't configured yet.
  
  Use it with:

  ````bash
  sudo nixos-rebuild switch .#arch
  ````

## Architecture

This configuration is following a set-profile pattern.

### Design Strategy

A **set** define a list of module that performing similar function.

A **profile** define the use of device and what sets of modules it should use.

### Import strategy

Every atomic nix modules are using `flake.Modules.{moduleName}`.

And while home modules are using `flake.homeModules.{moduleName}`.

Subdirectories will containing similar functioning modules, which will all imported in `default.nix`.

The file `default.nix` will be a module holding all sub-modules in the directory.

Then, they will be imported in `/sets`.

Finally, depends on **set**'s functioning, import in a **profile**.

### Benefit

In short: ***A-S-R-E***

- Atomic
- Simple
- Readable
- Editable

Which allows me (a noob) can easily write and manage my configurations.

## Contribution

I appreciate and welcome everyone give me an issue on any kind of improvements.

Apparently, this repo still have many flaws, so don't be too judgemental to me XD.

