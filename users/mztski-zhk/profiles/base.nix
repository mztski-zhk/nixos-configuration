{ config, ... }:
{
  flake.modules.homeManager.base.imports = with config.flake.modules.homeManager; [
    base
    utilities.cli
  ];
}